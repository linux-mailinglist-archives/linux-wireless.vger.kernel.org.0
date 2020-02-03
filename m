Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD7151257
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 23:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgBCW34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 17:29:56 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:40492 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgBCW34 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 17:29:56 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iykE5-00Eml6-SH; Mon, 03 Feb 2020 23:29:54 +0100
Message-ID: <0a39afdd47460597c51a0a6ea9871f78d9ea5854.camel@sipsolutions.net>
Subject: Re: mac80211: background scan issue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 03 Feb 2020 23:29:52 +0100
In-Reply-To: <DB8PR01MB5529FBFD07C989F0E934CDD990000@DB8PR01MB5529.eurprd01.prod.exchangelabs.com> (sfid-20200203_164721_336174_40CD3BE8)
References: <DB8PR01MB5529FBFD07C989F0E934CDD990000@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         (sfid-20200203_164721_336174_40CD3BE8)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

	
> @@ -297,7 +297,8 @@ ieee80211_tx_h_check_assoc(struct ieee80
>        if (unlikely(test_bit(SCAN_SW_SCANNING, &tx->local->scanning)) &&
>            test_bit(SDATA_STATE_OFFCHANNEL, &tx->sdata->state) &&
>            !ieee80211_is_probe_req(hdr->frame_control) &&
> -          !ieee80211_is_nullfunc(hdr->frame_control))
> +          !ieee80211_is_nullfunc(hdr->frame_control) &&
> +              !ieee80211_is_qos_nullfunc(hdr->frame_control))
>                /*
>                 * When software scanning only nullfunc frames (to notify
>                 * the sleep state to the AP) and probe requests (for the

yeah, Thomas also found it, we now have this in the tree:

        if (unlikely(test_bit(SCAN_SW_SCANNING, &tx->local->scanning)) &&
            test_bit(SDATA_STATE_OFFCHANNEL, &tx->sdata->state) &&
            !ieee80211_is_probe_req(hdr->frame_control) &&
            !ieee80211_is_any_nullfunc(hdr->frame_control))

johannes

