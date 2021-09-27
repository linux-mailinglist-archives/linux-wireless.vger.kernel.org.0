Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10276419316
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 13:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhI0L3z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 07:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhI0L3y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 07:29:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB6DC061575
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Cmq7PqsgqoI+LbrAJLMGvvIn2XTpbqmWI6SQWZSpIeo=;
        t=1632742097; x=1633951697; b=mwrQ2Ze1rFXuxeJHDCR+kERBhS36bXBJCwIzDqjOciYlzTx
        g2DdrHD0/8uVjkyiyZTwR2D0xgQhJ8s7e34x38tK24hc+t/X/J1fRZsJamKS4WbL7vlCaDiidJy0+
        e6i3uzeFYyeJyPPoZwxJ/tWAQn+pF5xYeIiMW8ZygngXJeK8ARMoWlYwzzzIug+ppBXch6P7ISwJ7
        +CSaPksG3d1LULXTeA+D18Z2rFAnRC0mgoKjO2Mx0im4ptevkVp7Qt89OVw3LvRCmu3juFWEAnWI9
        gsn/y/Jtqxevjwk8Dz/AAPNCp61E5TxXXg/CLB9W4JGgiIc0CXCgCCEwuupHwXPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mUons-00COfc-VU;
        Mon, 27 Sep 2021 13:28:13 +0200
Message-ID: <56754afbae715eb64bd82269fa9bd79bdc5f4447.camel@sipsolutions.net>
Subject: Re: [PATCH v4 3/6] cfg80211: add definition for 6 GHz power
 spectral density(psd)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 27 Sep 2021 13:28:12 +0200
In-Reply-To: <20210924100052.32029-4-wgong@codeaurora.org>
References: <20210924100052.32029-1-wgong@codeaurora.org>
         <20210924100052.32029-4-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-09-24 at 06:00 -0400, Wen Gong wrote:
> 
>  	NL80211_RRF_NO_80MHZ		= 1<<15,
>  	NL80211_RRF_NO_160MHZ		= 1<<16,
>  	NL80211_RRF_NO_HE		= 1<<17,
> +	NL80211_RRF_PSD		= 1<<18,

Indentation seems to be missing a tab here.

johannes

