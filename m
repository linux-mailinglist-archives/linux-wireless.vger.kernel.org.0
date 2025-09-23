Return-Path: <linux-wireless+bounces-27624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B2B97EBE
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7806016A3BF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 00:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934DF1A83FB;
	Wed, 24 Sep 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="RismTvs4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0111A0BD6
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674621; cv=pass; b=QIxkxSa0dMIC8WJRHtT04fL7Jvubl1uTPR3n1tI+pTzzA1KxMkYdNfYqVmaLWtLHsVrfj0BNdpPX9Te2D/vQBjQVMaWQodSYDhfVY1DkIcwJZN+AiQFm6hivc/nLj357NfVUCfMplxKg2zlNNGVQK2lnkLLCUTYcxvYNMBaGZFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674621; c=relaxed/simple;
	bh=i0J7m3oEakkzh2asLi3BFua6bwl+B3/+nNerHBG+61E=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=EqkG6nY88GWva3d4STFmPS2yV0Qzd67/Wz/qslSQPguFO2CMocRZGg9lfcSPBtsegmZYSF1BDVWm/ztwfL7wbQAhTueW0MGWtUgBwfmbiIyjnY3isotnN7qGp23URNU+pBERHWgUjy1xuTE7WzM8/lyMUZZkOFbh/UsPRbfh0RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=RismTvs4; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674619; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=dntoFdRdq5sFguaobXJqxe3h6v814kjSt+c56kY8xS2bpiIv/DAjn1595kvBkImUAeknQrNnJ/TW0ANF1eoLNCOrljLN9OQpIHgoCy+Qyl3U2wBkykYHicxDGaV78+ZEMRhuckkUMHE9RGzZohgd/xonj49WSPVFU8rc6jU/u/E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674619; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=i0J7m3oEakkzh2asLi3BFua6bwl+B3/+nNerHBG+61E=; 
	b=XkaNrDeQsAG0c0ZC4Ot1Xld54v2Sp3RxVwcuwjxpzQdQ4hWzsh/Lm14ED+vJyhKGLb7+Lo/GDP5SGnrbMmY/Ytbqb0YSpq13zm9w8ROa8FeiFRUJU0wS4ouHpkfsHQQZuA58dyQlLdB8+HSYAGduIAXD9yREFApnOfP+DxOuz04=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9abcfcc0-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671652941861.6912488143008;
	Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=RismTvs4t0zhXKwst2r6RusD8BtPz6ED3+POh9EtB8aeq7PTQBwqUz/jqhHcUi01H02MRqcrdBYB97UO+xIPZgtFrqMlhOYdx7zHQvx6zfeRoY+2FzT4+hNE0Ybhj2dvKoNpT1JsOaAG4agdoBz0fwZOfyt7/IVZh6KGtEbEJOQ=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=i0J7m3oEakkzh2asLi3BFua6bwl+B3/+nNerHBG+61E=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-wireless@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9abcfcc0-98d8-11f0-9ce0-52540088df93.19978ffc68c@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9abcfcc0-98d8-11f0-9ce0-52540088df93.19978ffc68c
X-JID: 2d6f.1aedd99b146bc1ac.s1.9abcfcc0-98d8-11f0-9ce0-52540088df93.19978ffc68c
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9abcfcc0-98d8-11f0-9ce0-52540088df93.19978ffc68c
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9abcfcc0-98d8-11f0-9ce0-52540088df93.19978ffc68c
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9abcfcc0-98d8-11f0-9ce0-52540088df93.19978ffc68c@zeptomail.com>
X-ZohoMailClient: External

To: linux-wireless@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

