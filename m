Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E052FC6E1
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 02:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbhATBey (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 20:34:54 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:23790 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbhATBev (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 20:34:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611106467; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=42dKRppIOyrdZZlZCu6ORjPRXglZK5b6ce6DTvCMMn8=; b=Xie4af1AWx/p6rFw6y94akeGk1e9AZMvhKizcDfuNuPmH2kpFMAAHA+laJweaK5Q0trNvkPu
 cwYsnij99rWY0GwoA8wpaRQMuyJCW3d+EcJvomGfG4Cc2cpyx1HlNy9jfPYw4xDqTVn4HKlz
 8d3WPYLGbjKRhjr7yyQrd0lw+uU=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60078886fd7e724dd3d7c4b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Jan 2021 01:33:58
 GMT
Sender: miaoqing=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42DF0C43462; Wed, 20 Jan 2021 01:33:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        PDS_BAD_THREAD_QP_64,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from miaoqing1 (unknown [183.195.1.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7D89C433ED;
        Wed, 20 Jan 2021 01:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7D89C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=miaoqing@codeaurora.org
From:   <miaoqing@codeaurora.org>
To:     "'Kalle Valo'" <kvalo@codeaurora.org>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <1608515579-1066-1-git-send-email-miaoqing@codeaurora.org> <20210118161650.4B9BAC43461@smtp.codeaurora.org>
In-Reply-To: <20210118161650.4B9BAC43461@smtp.codeaurora.org>
Subject: RE: [PATCH] ath10k: fix wmi mgmt tx queue full due to race condition
Date:   Wed, 20 Jan 2021 09:33:51 +0800
Message-ID: <00b001d6eecc$51284120$f378c360$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHx/gcHY99Iai/GqEFrts5lbNgOgAI8Q3ECqee6IgA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Please address Brian's comments and send v2.
>=20
> Patch set to Changes Requested.

Updated.
https://patchwork.kernel.org/project/linux-wireless/patch/1608618887-8857=
-1-git-send-email-miaoqing@codeaurora.org/

