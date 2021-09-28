Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6FA41AF9B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 15:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbhI1NE1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbhI1NEZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 09:04:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBAEC061604
        for <linux-wireless@vger.kernel.org>; Tue, 28 Sep 2021 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=82QXwbQwRc7AQzFplXvtgyMLY9lq/mlIgdTi9zboqE4=;
        t=1632834166; x=1634043766; b=ffGdfcV37MlvsjVqvX41pbirUBLLpY6m1Xzrw4IxaoMhtfR
        asp51mlb8lXEdBtmA4I+V7rxVpBNCKxe7ibtn6UOEd4SquIshWcYR+tsOV2U3jK62sJKvnHLMYvut
        be8+Xqr0mx+1sT3mXaN9Yh3scX2+ZsY2M48ES1fGMVISBXFRI1BLfDKtCrPx3ob5JGmaCXM5VNm4g
        e6cKGHaPbzRfnU/iWSqUssrYh2H5J/SNs35MpW66QCC+8bBrVBKuYhoQbJiwtAQJhZmyzVakwD0Ij
        ilTXTgjjGfQvvhXkPJwAWEaSeCbe2/d93A0yXpU9+AwAeowJ7+M1LXMZX5gCQTpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mVCkp-00CsjS-Ux;
        Tue, 28 Sep 2021 15:02:40 +0200
Message-ID: <b6c96c4ecdf9ec175d7f89e8600fb53768287cc2.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/2] mac80211: do intersection with he mcs and nss
 set of peer and own
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 28 Sep 2021 15:02:39 +0200
In-Reply-To: <1609816120-9411-3-git-send-email-wgong@codeaurora.org> (sfid-20210105_041051_256789_4F276B28)
References: <1609816120-9411-1-git-send-email-wgong@codeaurora.org>
         <1609816120-9411-3-git-send-email-wgong@codeaurora.org>
         (sfid-20210105_041051_256789_4F276B28)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,


I had done a bunch of fixups to this patch, but the zero-day build robot
correctly reports that:

> +	ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_80,
> +				      &he_cap->he_mcs_nss_supp.rx_mcs_80,
> +				      &own_he_cap.he_mcs_nss_supp.tx_mcs_80,
> +				      &he_cap->he_mcs_nss_supp.tx_mcs_80);

the &own_he_cap... parts here will take an __le16 pointer to a possibly
unaligned variable - any thoughts how we could fix that?

johannes

