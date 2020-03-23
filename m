Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0889A18F66D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgCWN4u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:56:50 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48150 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgCWN4u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:56:50 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGNZQ-002Kvm-9e; Mon, 23 Mar 2020 14:56:48 +0100
Message-ID: <30484acdee4cd19078673f4f4229dfae49b17804.camel@sipsolutions.net>
Subject: wmediumd MAC implementation/simulation
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Bob Copeland <me@bobcopeland.com>,
        Masashi Honma <masashi.honma@gmail.com>
Date:   Mon, 23 Mar 2020 14:56:46 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Clearly, the MAC simulation in wmediumd is rather limited, basically the
code just munges everything together:

        for (i = 0; i < frame->tx_rates_count && !is_acked; i++) {

                rate_idx = frame->tx_rates[i].idx;

                /* no more rates in MRR */
                if (rate_idx < 0)
                        break;

                error_prob = ctx->get_error_prob(ctx, snr, rate_idx,
                                                 frame->freq, frame->data_len,
                                                 station, deststa);
                for (j = 0; j < frame->tx_rates[i].count; j++) {
                        send_time += difs + pkt_duration(frame->data_len,
                                index_to_rate(rate_idx, frame->freq));

                        retries++;

                        /* skip ack/backoff/retries for noack frames */
                        if (noack) {
                                is_acked = true;
                                break;
                        }

                        /* TODO TXOPs */

                        /* backoff */
                        if (j > 0) {
                                send_time += (cw * slot_time) / 2;
                                cw = (cw << 1) + 1;
                                if (cw > queue->cw_max)
                                        cw = queue->cw_max;
                        }

                        send_time += ack_time_usec;

                        if (choice > error_prob) {
                                is_acked = true;
                                break;
                        }

                        if (!use_fixed_random_value(ctx))
                                choice = drand48();
                }
        }

        if (is_acked) {
                frame->tx_rates[i-1].count = j + 1;
                for (; i < frame->tx_rates_count; i++) {
                        frame->tx_rates[i].idx = -1;
                        frame->tx_rates[i].count = -1;
                }
                frame->flags |= HWSIM_TX_STAT_ACK;
        }

(I copy/pasted that from my version, may be slightly different than
current upstream due to a fix bugfixes. I also know the recent fixes
will touch this area. Anyway, that's not the point.)


Looking at this, one thing that immediately stands out is that the ACK
isn't actually transmitted in any way, so you cannot have a duplicate
transmission that's actually received and get the ACK back.

And the second thing, because of this, it's highly unsuitable for
actually integrating with some other MAC.


The way I see it, wmediumd serves a dual purpose in this code,
implementing both

1) the low-level MAC controller for hwsim, and
2) the actual medium simulation.

I wonder if this should be split, implementing a "real" MAC for hwsim,
and then sending also the ACKs "properly", perhaps implementing RTS/CTS
behaviour in the MAC, etc.?

Or perhaps then that's too much complexity and I should just teach ns3
the hwsim virtio interface?

johannes

