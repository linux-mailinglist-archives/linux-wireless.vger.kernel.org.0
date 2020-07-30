Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4C8233297
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgG3NFi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3NFg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:05:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D96EC061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 06:05:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k18Fa-00DXJY-GP; Thu, 30 Jul 2020 15:05:34 +0200
Message-ID: <a29acdbce66cda7d2fa6db9798a2f32b0668a832.camel@sipsolutions.net>
Subject: Re: [PATCH V2 04/10] mac80211: add multiple bssid IE parsing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 30 Jul 2020 15:05:33 +0200
In-Reply-To: <20200706115219.663650-4-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
         <20200706115219.663650-4-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-07-06 at 13:52 +0200, John Crispin wrote:
> 
> + * @mbssid_offset: position of mbssid_offset
> + * @mbssid_length: position of mbssid_offset
> 
> +
> +	u16 multiple_bssid_offset;
> +	u16 multiple_bssid_length;

that doesn't match :)


Oh. This patch is both AP- and client-side ... got confused there a bit
:)

johannes

