Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8557A41F211
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354849AbhJAQWz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 12:22:55 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:30794 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354749AbhJAQWy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 12:22:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633105269; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=E0TfD1T+crhBYlVEdefSLNiXIyvI7Fx9VpRjpfC1cY0=; b=pYZVWW03dKJqbPkY9YaRSuLLqhHZsS5h9K+ZRQFhUJ6SNBtQKlVXjUri8T3iwbiDrxrPxzO0
 Ui1l3OBGQzsbB5B9A1OfkmlQ+9td0+4nvF7C+COSPRSSxTapZtvE00ABghd7r6vdf/U7GWS1
 7r0j3QX2vLvWekpweZc47Y1PYR0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6157356947d64efb6d84d938 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 16:20:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D11FC4360C; Fri,  1 Oct 2021 16:20:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D8AFC43460;
        Fri,  1 Oct 2021 16:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2D8AFC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 13/24] rtw89: 8852a: add 8852a specific files
References: <20210820043538.12424-1-pkshih@realtek.com>
        <20210820043538.12424-14-pkshih@realtek.com>
Date:   Fri, 01 Oct 2021 19:20:53 +0300
In-Reply-To: <20210820043538.12424-14-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 20 Aug 2021 12:35:27 +0800")
Message-ID: <87bl48iumy.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> The 8852A specific chip info and ops are written in this file. The chip
> info describes the chip specific capabilities, and chip ops are specific
> efuse parser, FEM setup, set channel, RFK trigger, set TX power, and
> WL/BT grant controlled by coex.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static struct rtw89_hfc_ch_cfg rtw8852a_hfc_chcfg_pcie[] = {
> +	{128, 1896, grp_0}, /* ACH 0 */
> +	{128, 1896, grp_0}, /* ACH 1 */
> +	{128, 1896, grp_0}, /* ACH 2 */
> +	{128, 1896, grp_0}, /* ACH 3 */
> +	{128, 1896, grp_1}, /* ACH 4 */
> +	{128, 1896, grp_1}, /* ACH 5 */
> +	{128, 1896, grp_1}, /* ACH 6 */
> +	{128, 1896, grp_1}, /* ACH 7 */
> +	{32, 1896, grp_0}, /* B0MGQ */
> +	{128, 1896, grp_0}, /* B0HIQ */
> +	{32, 1896, grp_1}, /* B1MGQ */
> +	{128, 1896, grp_1}, /* B1HIQ */
> +	{40, 0, 0} /* FWCMDQ */
> +};
> +
> +static struct rtw89_hfc_pub_cfg rtw8852a_hfc_pubcfg_pcie = {
> +	1896, /* Group 0 */
> +	1896, /* Group 1 */
> +	3792, /* Public Max */
> +	0 /* WP threshold */
> +};
> +
> +static struct rtw89_hfc_param_ini rtw8852a_hfc_param_ini_pcie[] = {
> +	[RTW89_QTA_SCC] = {rtw8852a_hfc_chcfg_pcie, &rtw8852a_hfc_pubcfg_pcie,
> +			   &rtw_hfc_preccfg_pcie, RTW89_HCIFC_POH},
> +	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw_hfc_preccfg_pcie, RTW89_HCIFC_POH},
> +	[RTW89_QTA_INVALID] = {NULL},
> +};
> +
> +static struct rtw89_dle_mem rtw8852a_dle_mem_pcie[] = {
> +	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &wde_size0, &ple_size0, &wde_qt0,
> +			    &wde_qt0, &ple_qt4, &ple_qt5},
> +	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &wde_size4, &ple_size4,
> +			    &wde_qt4, &wde_qt4, &ple_qt13, &ple_qt13},
> +	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
> +			       NULL},
> +};

const? I also see more variables in this file which I suspect to be
const, but running out of time. Please check those as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
