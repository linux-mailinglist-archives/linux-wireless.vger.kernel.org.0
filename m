Return-Path: <linux-wireless+bounces-23943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9083EAD477C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 02:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516EB17B84B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 00:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22B314F70;
	Wed, 11 Jun 2025 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jrEGrHxf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590623CE;
	Wed, 11 Jun 2025 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749601948; cv=none; b=O325YO4mLKDueSsKT6KwCLVWTQfKejO5FkBH6Tnpd91U46DgSWXLHMwytnr/dRolps6fp6SQaZVlsl022CrSCl84wv1tQSi6OvBh+eCK94oLTBHHOYPIrjNMgm1ewBbrjFhSZv85SwsPng7RneTpVGputlMFjnHsML3vuJ9mZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749601948; c=relaxed/simple;
	bh=NhHIAPnTaLGJh8uoGOn99qrVxLppk0NZa9mQDuaKMvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e4++UtZMAqAUBsVb2Op/N/2AsgkAFqxwlkcEBShFhYKI+n7RVZfy+6N/By3tZ3xTPbnaVCFXIm6f4Tef/FYzFcGAwXiIlVDEFAT174v600AA6wigs3AOrfwZCahsMNvhwDvnz8jPgWMjg9CaTQQ1DAxmEK9b5a8OKHfze/5eH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jrEGrHxf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B0WAHq83864311, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749601930; bh=NhHIAPnTaLGJh8uoGOn99qrVxLppk0NZa9mQDuaKMvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jrEGrHxfPAH6VYW9q5iuwAGXafSiKRIctTnGADha3y+/DD1/si2ynqF+2DEbZFg0r
	 mQrJDc6pvoKR5yfwEQuiz89W26whoJ3S+449eSVAM3FjDeCvgp0X8NVTwNkpDdMURi
	 ETjXAjzk5URvBlM3zmSOtgwWGy+XdZOEGykwP/0BSrkgBSXWwww6RkasJhpc4LZxrc
	 OykHusY3q1LyIl8a/+sblcc3iPHkBnmu/reOpxXBOfGmQF7kzGe+ImSsnuFxrBvU4h
	 qLc3n/oSL2QfmEGBS4rLVZtVMjeQ3u/fRyVs+OK3NGxfDQHTYiaPlBlcyd6NNx3Sqj
	 p1vLLEAo3PWYA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B0WAHq83864311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 08:32:10 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 08:32:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 11 Jun 2025 08:32:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 11 Jun 2025 08:32:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        kernel test robot
	<lkp@intel.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: RE: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB modules
Thread-Topic: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB
 modules
Thread-Index: AQHb2XV4UvlgvG5pOESwpZNcSugO9rP7xDMAgAAbN4CAATzvcA==
Date: Wed, 11 Jun 2025 00:32:10 +0000
Message-ID: <01eb10716bdb4241a012d378d1f7b67d@realtek.com>
References: <663044d3-0816-4b1b-874d-776835e774e9@gmail.com>
 <202506101956.cNXM2Qvb-lkp@intel.com>
 <b8690413-059d-4330-992b-36a7af10aa30@gmail.com>
In-Reply-To: <b8690413-059d-4330-992b-36a7af10aa30@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiA+DQo+ID4+PiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTFiLmM6
NTIzOjQ3OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllcg0KPiAnQl9BWF9TT1Bf
RURTV1InDQo+ID4gICAgICA1MjMgfCAgICAgICAgICAgICAgICAgcnR3ODlfd3JpdGUzMl9jbHIo
cnR3ZGV2LCBSX0FYX1NZU19QV19DVFJMLCBCX0FYX1NPUF9FRFNXUik7DQo+ID4gICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeDQo+ID4gICAgMSBlcnJvciBnZW5lcmF0ZWQuDQo+ID4NCj4gT29wcywgSSdsbCBhZGQg
dGhhdCB0byByZWcuaCBpbiB2My4NCg0KVGhlIE5BUEkgYWxzbyByZXBvcnRlZCB0aGUgc2FtZSB0
aGluZ3MgWzFdIFsyXS4NCg0KTm90IHN1cmUgaWYgeW91IHdpbGwgc2VuZCB2MyByaWdodCBhd2F5
LiBJZiBzbywgSSB3aWxsIGlnbm9yZSB2Mi4gDQoNClsxXSBodHRwOi8vd2lmaWJvdC5zaXBzb2x1
dGlvbnMubmV0L3Jlc3VsdHMvOTY5OTgwLzE0MTExMTg3L2J1aWxkXzMyYml0L3N0ZGVycg0KWzJd
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9saXN0
Lz9zZXJpZXM9OTY5OTgwDQoNCg==

