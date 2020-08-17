Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8F2463DE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHQJ7C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 05:59:02 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:55868 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbgHQJ7B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 05:59:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597658341; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=r47RPWSXqNT1XWwAvDmNKYquEbOTrGWH9VNHjFO0QdY=; b=ehmn6u/oA1cjexF/hOBHWr6INcW362nJY17CP22nfdvYN8yIR5yjoZriD6JtdmmOiWzzJUr6
 YrASbUNDpQHI90CSyMIrjhgM//dNAncWXRaqhoi3gmkkqkMhLs7wK5iZKNu4G6crZpqY8CkZ
 2MsKZbL9f1ivZOqru2EF0+fOfU4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f3a54e161f1d418342a2767 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 09:58:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DA09C433CB; Mon, 17 Aug 2020 09:58:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A557CC433CA;
        Mon, 17 Aug 2020 09:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A557CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     ath10k@lists.infradead.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org
Subject: Re: CVE-2020-3702: Firmware updates for ath9k and ath10k chips
References: <20200810090126.mtu3uocpcjg5se5e@pali>
Date:   Mon, 17 Aug 2020 12:58:52 +0300
In-Reply-To: <20200810090126.mtu3uocpcjg5se5e@pali> ("Pali \=\?utf-8\?Q\?Roh\?\=
 \=\?utf-8\?Q\?\=C3\=A1r\=22's\?\= message of
        "Mon, 10 Aug 2020 11:01:26 +0200")
Message-ID: <87a6ytlhk3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> ESET engineers on their blog published some information about new
> security vulnerability CVE-2020-3702 in ath9k wifi cards:
> https://www.welivesecurity.com/2020/08/06/beyond-kr00k-even-more-wifi-chi=
ps-vulnerable-eavesdropping/
>
> According to Qualcomm security bulletin this CVE-2020-3702 affects also
> some Qualcomm IPQ chips which are handled by ath10k driver:
> https://www.qualcomm.com/company/product-security/bulletins/august-2020-s=
ecurity-bulletin#_cve-2020-3702

I can't find any refererences to ath10k, or hardware with ath10k
chipsets, in the links above. Where did you see it?

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
