Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43ED65213C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 14:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiLTNGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 08:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiLTNGb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 08:06:31 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0736AE0A9
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 05:06:27 -0800 (PST)
Received: from smtpclient.apple (p4fefcc21.dip0.t-ipconnect.de [79.239.204.33])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2BAC7CED05;
        Tue, 20 Dec 2022 14:06:27 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20221220043823.20382-1-quic_mpubbise@quicinc.com>
Date:   Tue, 20 Dec 2022 14:06:26 +0100
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5DAEA8B2-2B44-4A91-9E57-12B6C6B6C1FC@holtmann.org>
References: <20221220043823.20382-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Manikanta,

> Currently, time taken to scan all supported channels on WCN6750
> is ~8 seconds and connection time is almost 10 seconds. WCN6750
> supports three Wi-Fi bands (i.e., 2.4/5/6 GHz) and the numbers of
> channels for scan come around ~100 channels (default case).
> Since the chip doesn't have support for DBS (Dual Band Simultaneous),
> scans cannot be parallelized resulting in longer scan times.
> 
> Among the 100 odd channels, ~60 channels are in 6 GHz band. Therefore,
> optimizing the scan for 6 GHz channels will bring down the overall
> scan time.
> 
> WCN6750 firmware has support to scan a 6 GHz channel based on co-located
> AP information i.e., RNR IE which is found in the legacy 2.4/5 GHz scan
> results. When a scan request with all supported channel list is enqueued
> to the firmware, then based on WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND
> scan channel flag, firmware will scan only those 6 GHz channels for which
> RNR IEs are found in the legacy scan results.
> 
> In the proposed design, based on NL80211_SCAN_FLAG_COLOCATED_6GHZ scan
> flag, driver will set the WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND flag
> for non-PSC channels. Since there is high probability to find 6 GHz APs
> on PSC channels, these channels are always scanned. Only non-PSC channels
> are selectively scanned based on cached RNR information from the legacy
> scan results.
> 
> If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set in the scan flags,
> then scan will happen on all supported channels (default behavior).

is this really a good idea? The interpretation on what scan results will
be reported would be preferable the same no matter what hardware is
present. Why would ath11k now have a different behavior?

And more important, why is this something driver or even Linux kernel
specific. Let userspace select the frequencies to scan.

Looks like that iwd and wpa_supplicant set this flag regardless which
means to me that a driver should respect the requested frequencies to
be scanned.

Anyhow, if you worry about time-to-connect, then fix userspace to be
smart with scanning. I am also confused on how a savings of 1.5 seconds
out of 8 seconds is significant. It still means you spent 6+ seconds
in the 2.4 GHz and 5 GHz bands. I assume that you spent most time in
5 GHz right now.

I highly doubt that a 6+ seconds plus 2 seconds connection time is
anywhere acceptable. Have you tried using iwd and see what the
connection time actually is after initial connection.

Regards

Marcel

