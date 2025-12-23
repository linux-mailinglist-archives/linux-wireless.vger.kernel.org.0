Return-Path: <linux-wireless+bounces-30078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C41CD824C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 06:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CD8B30191AC
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 05:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6882EF67A;
	Tue, 23 Dec 2025 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q761gJFt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80C1990A7;
	Tue, 23 Dec 2025 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467581; cv=none; b=gUVbBYU9CF/5uDqBZDmZ+JkAvoJ+iXZNBfz1ogb1oweqA/NKEx+9Y6x0OdZxaEEvAuD/lsp8iaYWc7eQckyS/6haZ6/aiP1+yCFe/Y1ZcAttE8IzZC5CCbQHpjYK/vytvo4OGlsRlku6aONbVzwEJVr67qMMvLYKni7MEKc4Q/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467581; c=relaxed/simple;
	bh=VovFXJHvgxodN7+Rqo8yoNYmdKIInrisMroN8Dd8Xxk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=ToRhoLP5mMwjfOq9q9tF/i0aJQaVd6T7vCviDclWX9gukS7Cy9g8klB5Vs853vt1PlEphPBC3Y9h13Zink/5wgaallaDTOjIvZtEXNx8YHM3WvnjZak1VaTp/E3k/WTfWr6uhrrh3ZMfgPUT3mh0gXok6mG5PWxsxLlXi4ghZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q761gJFt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN5QFQN0757096, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766467575; bh=23vW4+bXgGUASDbUvk2uVlOqLVwEuWRTmkwmPVEfDU8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Q761gJFtzl+9We8sDcXtglBl7T+pVRgR+px8P7uXnprCbpLKRH8oaDUTnn96Rc7IV
	 kl6MNuPCCnlvyrtu6mVnyx0J+Q3XgIZh5l0AfaYzvIE0gknR25MVQxrfhz5VKkctnD
	 WzQMAXKF1aRWXLRXCZXVNOC5C31GIo8QRowZWkZJeHmb6Z2aQb9a0vqh865lRt6+FA
	 aep13gxryKXjJalqJEPkemEiHYfzgDYytzZV8tXw8xXN2MiNag7+LARR8r/q/BMo77
	 z7LIHhjBvz2RsJsK2ZQVsBDIccuk9jtmRpknluCWj5Wsp2hDW114HvPysPEabH2om+
	 WbJeVdeF46PEw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN5QFQN0757096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 13:26:15 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 13:26:15 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 13:26:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <chourasiarohit27@gmail.com>, <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rohit
 Chourasia <chourasiarohit27@gmail.com>
Subject: =?utf-8?Q?Re:_[PATCH]_rtlwifi:_fix_typo_in_comment_(recieved_=E2=86=92_received)?=
In-Reply-To: <20251211161911.30611-1-chourasiarohit27@gmail.com>
References: <20251211161911.30611-1-chourasiarohit27@gmail.com>
Message-ID: <38f231fb-6670-4c0d-ace9-7c112fcfc76a@RTKEXHMBS04.realtek.com.tw>
Date: Tue, 23 Dec 2025 13:26:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

chourasiarohit27@gmail.com wrote:

> From: Rohit Chourasia <chourasiarohit27@gmail.com>
> 
> Signed-off-by: Rohit Chourasia <chourasiarohit27@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

af04c1e8e7a9 wifi: rtlwifi: fix typo 'received' in comment

---
https://github.com/pkshih/rtw.git


