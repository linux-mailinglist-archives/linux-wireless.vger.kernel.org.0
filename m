Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67B8403AC5
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhIHNfJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 09:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhIHNfI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 09:35:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EADC061575
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oYG27kL84Z+rcW/Hw3kRmoAN7MOZKku3ykHUmjVQM5k=;
        t=1631108040; x=1632317640; b=K4guVoJYFBQcrfbfAc4sxHZ+RDfKsyjUzb3jo5Np8ZDBnSl
        UClWqhzWgxUUsE79kt7bcctJvv1Yyz5YBKEBAlvqreNNjYbIVbBOj60wgoFWfX+lViblEfIXL2DBJ
        EUgnPL40FIo2F9CVKd568quwCA5lPC+vaKGj7xRkfF7FLwyj2dnGgbmKCA7Y7xvjTsJLZAWiJrQ4K
        8Pa12gd3jIf6bveX5rl95zerz/0c2yA4EBSWZP4T0xi9g1zw7eQL1atCJZlTKLbl0+pomr7B9HHY4
        6XfXE/8p5Jy3IPr7BAsroVmr7esYBMyk610mUoMBBE2dppddOrSmpNTVxpkuiUvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mNxi8-004Kzg-Hf;
        Wed, 08 Sep 2021 15:33:56 +0200
Message-ID: <19691c5bc144eb525530974813812a86937a0a91.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wcn36xx: Add ability for wcn36xx_smd_dump_cmd_req
 to pass two's complement
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com
Date:   Wed, 08 Sep 2021 15:33:55 +0200
In-Reply-To: <20210908133019.2408092-3-bryan.odonoghue@linaro.org>
References: <20210908133019.2408092-1-bryan.odonoghue@linaro.org>
         <20210908133019.2408092-3-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-09-08 at 14:30 +0100, Bryan O'Donoghue wrote:
> 
> iwpriv wlan0 dump 71 3 <schedule period> <trigger threshold> <hysteresis>

Ouch. The last millenium called and wants its technology back ;-)

johannes

