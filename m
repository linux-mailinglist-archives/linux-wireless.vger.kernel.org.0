Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8118D43A479
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 22:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhJYUZ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 16:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbhJYUZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 16:25:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D19C061231
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nkkwgBBru0cXAEZmmwkj0DeO6uvblFpcia5i86HDw0I=;
        t=1635192635; x=1636402235; b=tdiNjS2pKuAbo9aGIQoAKo+CRqa3wIBY0P6hXLV+av8b3+y
        812UB3Kx+ip8CBEwqBXmhhCdoFr7obnktGLn2Mxrr1FTOcI8MrA5Lre5+AbQT+hIR56k5szMJpA5i
        xHE016sre9ruda8pBjOO7vVQygANqP+R2wSmPDnTA01DkAyfjBWg8e7qxfSf8DPGxCmWfjGLeGCMF
        VhwAQqaw15JBJEHR1GlB+6LKRvdDmnFBDGKLMD0uR+cQAo11fQ/1xG4UAOSW6t2MVx3evCmwbI7Az
        17suT0WsQA++EulmwYcnDXeQpT8iKkvZK/dQpiPGmROaObXGSIg6Lym6PY4pwRGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mf6Ij-006qTm-N3;
        Mon, 25 Oct 2021 22:10:33 +0200
Message-ID: <84fcbf3d0e53ba6e76a8396c7800acb72426053c.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/3] ath11k: Add ROC support for wide band scan
From:   Johannes Berg <johannes@sipsolutions.net>
To:     P Praneesh <ppranees@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>
Date:   Mon, 25 Oct 2021 22:10:32 +0200
In-Reply-To: <1634906227-22028-4-git-send-email-ppranees@codeaurora.org>
References: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
         <1634906227-22028-4-git-send-email-ppranees@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FWIW, not sure how this patch got mislabeled as 2/3 when it should be
3/3, but that caused patchwork to drop it. Might want to fix that when
you resend so that Kalle can actually see both.

johannes

