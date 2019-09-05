Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162DCAA37F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbfIEMu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 08:50:27 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36754 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbfIEMu1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 08:50:27 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i5rDV-0001I3-B8; Thu, 05 Sep 2019 14:50:25 +0200
Message-ID: <45e530c7066090878470e65a0e74738b98aacef0.camel@sipsolutions.net>
Subject: Re: [PATCH 31/49] ath11k: add mac.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Date:   Thu, 05 Sep 2019 14:50:24 +0200
In-Reply-To: <87woenkjt7.fsf@kamboji.qca.qualcomm.com>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
         <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
         <4076919b34cad119eb4146025f587285ef40e37c.camel@sipsolutions.net>
         <ee38dc5e80097d0ebc186f81b2f11d37@codeaurora.org>
         <878sr3nfz8.fsf@kamboji.qca.qualcomm.com>
         <8e90a557c1659995d117c6dc8b728d7f@codeaurora.org>
         <87woenkjt7.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-09-05 at 15:29 +0300, Kalle Valo wrote:
> 
> Yeah, I was supposed to write:
> 
> "maybe we should change mac80211 to not require this op to be present"
> 
> But of course I could have just misunderstood, let's see what Johannes
> says :)

:-)

Yes, that's what I meant.

johannes

