Return-Path: <linux-wireless+bounces-4576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B74C878C0A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 01:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C961F21B74
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 00:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AF469D;
	Tue, 12 Mar 2024 00:51:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555364687;
	Tue, 12 Mar 2024 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710204705; cv=none; b=HIGlPkcUVVIUbGXclAvZ16YvoKNvGTDX2xupIVo+PUJF2gm6WsOmZamCEPcLzpqLtlnW8ixMIt5/XpljvpRRBAAg8hk8dhu6SMSXOlqx5VVM4CKdsWfKqzJBJeipIiBxW+OwnTx7pYQ5atCIUy/2aV5B8zC2AujThueYFMtxn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710204705; c=relaxed/simple;
	bh=I9K9BVLii/8HN8DV2WSlMkrYGU2lnprQPPb2YJacOaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T5O2pCYPIjka21aP/6WSbsotMhshs9zJ9kOxyeAnlXIien38RMjOU7N5cvUFPL5wflaBSpppc/bK5b9uo1GL0RhsvrI990CzqiZYk5m9U2n2uosIWxAB2jS02nFvP8dn41vOlS11K3JxYlST7xUe0A8O5sYc5NpbafFUqXYkjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42C0pRFk93912248, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42C0pRFk93912248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 08:51:27 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 08:51:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 08:51:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 12 Mar 2024 08:51:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: kernel test robot <lkp@intel.com>, "kvalo@kernel.org" <kvalo@kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        DeanKu
	<ku920601@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/6] wifi: rtw89: coex: Add WiFi role info format version 8
Thread-Topic: [PATCH 1/6] wifi: rtw89: coex: Add WiFi role info format version
 8
Thread-Index: AQHab3kFMtEkFRfg50iTnxaBVnS+xrEyIU8AgAEt2BA=
Date: Tue, 12 Mar 2024 00:51:27 +0000
Message-ID: <6c753d964f5e462a8a9afa63c2777cf0@realtek.com>
References: <20240306034558.19648-2-pkshih@realtek.com>
 <202403112247.DlQU3eaG-lkp@intel.com>
In-Reply-To: <202403112247.DlQU3eaG-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Monday, March 11, 2024 10:49 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org
> Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev; DeanKu <ku920601=
@realtek.com>;
> linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 1/6] wifi: rtw89: coex: Add WiFi role info format ver=
sion 8
>=20
> Hi Ping-Ke,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on wireless-next/main]
> [also build test WARNING on next-20240308]
> [cannot apply to wireless/main linus/master v6.8]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:
> https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-co=
ex-Add-WiFi-role-info-format-
> version-8/20240306-115058
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless=
-next.git main
> patch link:    https://lore.kernel.org/r/20240306034558.19648-2-pkshih%40=
realtek.com
> patch subject: [PATCH 1/6] wifi: rtw89: coex: Add WiFi role info format v=
ersion 8
> config: x86_64-allmodconfig
> (https://download.01.org/0day-ci/archive/20240311/202403112247.DlQU3eaG-l=
kp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project
> 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20240311/202403112247.DlQU3eaG-l=
kp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403112247.DlQU3eaG-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/net/wireless/realtek/rtw89/coex.c:5480:20: warning: variable '=
cnt_2g' set but not used
> [-Wunused-but-set-variable]
>     5480 |         u8 i, j, cnt =3D 0, cnt_2g =3D 0, cnt_5g =3D 0;
>          |                           ^
> >> drivers/net/wireless/realtek/rtw89/coex.c:5480:32: warning: variable '=
cnt_5g' set but not used
> [-Wunused-but-set-variable]
>     5480 |         u8 i, j, cnt =3D 0, cnt_2g =3D 0, cnt_5g =3D 0;
>          |                                       ^
>    2 warnings generated.
>=20

These two counters are prepared to support coming MLO, so I will add necess=
ary
debug messages ahead to avoid these warnings.=20

Ping-Ke=20


