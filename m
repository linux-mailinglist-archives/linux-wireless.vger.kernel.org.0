Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F93BAF37
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 10:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437095AbfIWIUj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 04:20:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392620AbfIWIUj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 04:20:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BFC6D60850; Mon, 23 Sep 2019 08:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569226837;
        bh=opFBMeR9OKIAgs+gJiPlz7sbZPKpmcRVcHLH4TchmV0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VkYcRmW5DLkgSzsKBGL1lrlxt6hIBCNeCselsSaCdMGE6Sw9w1srtykqdZBJ67FTf
         88AJ52STEqu26fpeZql/OPD4Ym52q6BPYKuTpkGM5yP6Qpi7AfvWV35aFgJmlFL4Mn
         EGqHS3d5vS9u43MXaTUderlJLFY9uNoAvxA9vdmk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D977A60850;
        Mon, 23 Sep 2019 08:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569226835;
        bh=opFBMeR9OKIAgs+gJiPlz7sbZPKpmcRVcHLH4TchmV0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=moCOTw8j8VEqHmTPQIoUtmTO1bElTmYrtiTooDvDxr6e4mXY1/taAWiTekUD9tlP0
         BOjqw4c7cE6Jx0vPHOn1+NnAT66nbgq0K3wj6G7hmouI0S77il6P8xCzpDoBVSSY58
         7ekY+O+ULysqQbfzvG2U83Hk9QVY22SPiCX1uwAk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D977A60850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Surabhi Vishnoi <svishnoi@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for per peer HTT tx stats for WCN3990
References: <1551251581-21193-1-git-send-email-svishnoi@codeaurora.org>
Date:   Mon, 23 Sep 2019 11:20:31 +0300
In-Reply-To: <1551251581-21193-1-git-send-email-svishnoi@codeaurora.org>
        (Surabhi Vishnoi's message of "Wed, 27 Feb 2019 12:42:59 +0530")
Message-ID: <875zlja0fk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Surabhi Vishnoi <svishnoi@codeaurora.org> writes:

> WCN3990 firmware sends the HTT_TLV_T2H_MSG_TYPE_PEER_STATS in tlv
> format so the handling of this message has to be done in different
> manner.
>
> This patchset adds support to attach rx_ops based on htt version
> and adds the handling of HTT_TLV_T2H_MSG_TYPE_PEER_STATS message
> based on HTT version.
>
> Surabhi Vishnoi (2):
>   ath10k: Add support for adding htt_rx_ops based on htt_version
>   ath10k: Add support for per peer HTT tx stats for WCN3990

When you resubmit, could you please include Rakesh's fixes in the same patchset:

ath10k: Fix rate table updation in tx stats
ath10k: Fix NSS tx stats for legacy rates

https://patchwork.kernel.org/project/linux-wireless/list/?series=90199&state=*&order=date

They depend on this patchset, so it's easier to handle them all
together.

-- 
Kalle Valo
