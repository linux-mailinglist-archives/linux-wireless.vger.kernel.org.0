Return-Path: <linux-wireless+bounces-30340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06315CF18F8
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 02:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB2203008FAD
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 01:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A952C0266;
	Mon,  5 Jan 2026 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kBjYdXNZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B92C0262;
	Mon,  5 Jan 2026 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767576442; cv=none; b=klTS1nm9A4z6UjTSXvqz6o1zU/yvP4c8q0N7AkUuZXkyqyast/kTZ5kZ/GJgDLE5Snp8uQTEPLAdOcD9dXyHsTNDTDtnOt3wihI46UnwFvlt0q+dZWGtdyPBoYEpv+pZXU6xoHbDTKJ55V9mhqeSmdzd3zb1WV/7J7eESTRnlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767576442; c=relaxed/simple;
	bh=czTi8EL6SnjaC+yPqQkcB6ddld0xdYLJC7ciOhQw5fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ASfv19YdbFRHEdmZ79ELQmrBRgjqqwLL+VvpCPvDm7tD0/R7VPf8er14SxZwnCFeLr15ICITis6DA7fNnd+kMlOvyYhN7Nd+FH+PRm9FJKdSmQIfSVl8iGnRrrYQ7b6CgG9XdNrzWsBnGo34Izah9owidihbViYFVa69lu5g/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kBjYdXNZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6051RAU301801700, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767576430; bh=czTi8EL6SnjaC+yPqQkcB6ddld0xdYLJC7ciOhQw5fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kBjYdXNZqccc6nLQVoeocQlq2GXrTd8K2KUsxnxqi0W1cDUQzcqWQvef4yUcCF/NV
	 A8nHONC0Lpta1emqBTXleaLvH3l6ay89ZGUKGIpP+8y0THtnUoQsDAf9FvYRzn0vq9
	 B7T52W4k3YNq45rekLUeR1B4g9jsiWfznuiZTbEeVOV55dBIQKKaM8CpbYv/3+xgTJ
	 AtRztBIHydeau/BLz+CPPKCg9DUPXyvbPRcCvuRTp2+RVRdgtAHDZn7p9UEc7V3TBb
	 Cr+NelBLxQOrPWkH0EkwA5VeYzJ8LapMsaWdPif3SYtZkgXgwi1XStyY/3Rrr8YXbZ
	 2DPQhnoMxV8rA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6051RAU301801700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Jan 2026 09:27:10 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 5 Jan 2026 09:27:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 5 Jan 2026 09:27:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 5 Jan 2026 09:27:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: kernel test robot <lkp@intel.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: RE: [PATCH rtw-next 04/10] wifi: rtw89: fw: add CMAC H2C command to
 initialize default value for RTL8922D
Thread-Topic: [PATCH rtw-next 04/10] wifi: rtw89: fw: add CMAC H2C command to
 initialize default value for RTL8922D
Thread-Index: AQHce7fYQeY00vIaLU64+KXFk2f5DbVAAw+AgALI8mA=
Date: Mon, 5 Jan 2026 01:27:10 +0000
Message-ID: <e5cccfc469324de1bcdb557cff9a88da@realtek.com>
References: <20260102070840.62047-5-pkshih@realtek.com>
 <202601031501.eUFh59B7-lkp@intel.com>
In-Reply-To: <202601031501.eUFh59B7-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on wireless-next/main]
> [also build test ERROR on wireless/main linus/master v6.19-rc3 next-20251=
219]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]

This patchset is based on the commit [1] of rtw/rtw-next tree [2], which
the tag 'rtw-next' in subject indicates this. I will use '--base' for futur=
e
submission.

[1] base-commit: 6a0b7392a6f5487fb58704926a24b1e2ee2762e9
[2] https://github.com/pkshih/rtw.git rtw-next


