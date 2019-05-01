Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE810A03
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 17:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfEAPZy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 11:25:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEAPZy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 11:25:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D75960735; Wed,  1 May 2019 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556724353;
        bh=L5W6NQ46o1GDCMhL5s7MAOl/KdCd2uwU5A8w+8Q0T2E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=my/HAFeTVer4JK3k5TeaVS/1RaMOKQaJslNmXDNUcYGcHL0VqUxjNmAxQB8VpStwH
         dgbB6E+eearb+0crVhLn4X7x6DlX2DzfbBfMNDS1MuzPNlSlJkofftPL0qJY12T8xS
         c9HQyiX8TvXLux35IvX+IzVAQd/H9DaSOsXCjvQY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1CA06044E;
        Wed,  1 May 2019 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556724353;
        bh=L5W6NQ46o1GDCMhL5s7MAOl/KdCd2uwU5A8w+8Q0T2E=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ba5w+yCTwe0jcl+HpqWsGuAaSpk4GXck+pXV8hdIMUSL7+q5HVwgmmKtdhB0CAJti
         gYdKSQsKmJLqPJtpZCWWXKs6ccS5ghdlxIt2Cc5PpjdAzJu2CGMMEKrS5NYGatqPWV
         mKHC5vGwlA198gV5E+9YHy/cG5yaOhtsAIv8FU+U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1CA06044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcm80211: potential NULL dereference in
 brcmf_cfg80211_vndr_cmds_dcmd_handler()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190424095218.GB16450@mwanda>
References: <20190424095218.GB16450@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190501152553.5D75960735@smtp.codeaurora.org>
Date:   Wed,  1 May 2019 15:25:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> If "ret_len" is negative then it could lead to a NULL dereference.
> 
> The "ret_len" value comes from nl80211_vendor_cmd(), if it's negative
> then we don't allocate the "dcmd_buf" buffer.  Then we pass "ret_len" to
> brcmf_fil_cmd_data_set() where it is cast to a very high u32 value.
> Most of the functions in that call tree check whether the buffer we pass
> is NULL but there are at least a couple places which don't such as
> brcmf_dbg_hex_dump() and brcmf_msgbuf_query_dcmd().  We memcpy() to and
> from the buffer so it would result in a NULL dereference.
> 
> The fix is to change the types so that "ret_len" can't be negative.  (If
> we memcpy() zero bytes to NULL, that's a no-op and doesn't cause an
> issue).
> 
> Fixes: 1bacb0487d0e ("brcmfmac: replace cfg80211 testmode with vendor command")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied to wireless-drivers-next.git, thanks.

e025da3d7aa4 brcm80211: potential NULL dereference in brcmf_cfg80211_vndr_cmds_dcmd_handler()

-- 
https://patchwork.kernel.org/patch/10914427/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

