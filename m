Return-Path: <linux-wireless+bounces-15743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C969DA266
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 07:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E1167013
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 06:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAD13B5AF;
	Wed, 27 Nov 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q+YlZ+U/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DDF9DD
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689551; cv=none; b=aEyj1ST7hXC/g3O4t4MyPARg6WyC7U2rMY6TcGc1vcBSiNMz/TsTsX9E03/eZtPqXnWjwWS69y2TQsAgKYE5ZRcKIDoF3kW7F7hvub9F6OIWshxQImTzXvD7ftrbYWFPPnTb5rS0J52r1e9TMGaomeDU5U0yB3wCrzk4FyCQOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689551; c=relaxed/simple;
	bh=qllNOu1jWeJsKqDHJJ98w91Zi6H3XUOzp2GEe7ouhaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mqVeGEIkb5pB7vJ6msVkt9Y3VE9bev+AB4O3/16BhZBIfTfYP8g8qT+PxEms5J60+rn0YAWiIMWqAoq44EBdjNjXy4PsUM6WHyw0q+NdkOOQbgnVkimmCHumGz26dcoswOmGQKI+OHS+r9xgT4rJC+rQp6ijKn2V1qLQ2jTvSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q+YlZ+U/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AR6cfozF2311048, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732689522; bh=qllNOu1jWeJsKqDHJJ98w91Zi6H3XUOzp2GEe7ouhaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Q+YlZ+U/V1EVhaoQW9O6vvnZiMLr85YYUfCo58cgTF0I1XODUx5aGrRWCltgiWtaw
	 W8Gu1+K6ua35pL2cSt3GvzU5CnjREUC/3KizJOx0IuMp0pQ5HHhmSQjtLiaED0Axcm
	 co4zCOXsZKY+QseDaXLz2Sq6dYs2f43IcBt/u1DjXd1jw/z+RRxSNpfEUiTbw4yXDj
	 OlbYEfG4bOGJJU/rE30+/3tHpe8lOXKg++tP/UEt5JzGVznxMPWFUaKYrA5gh537f9
	 00xlRX+xFX+6RGLUcvh21YRFKcg/QVkiZbBQhqQTg2brUrU4Jps1/YCcQIzolyGaIA
	 LnoiAly4UjrQA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AR6cfozF2311048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 14:38:41 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 14:38:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Nov 2024 14:38:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 27 Nov 2024 14:38:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH 3/4] wifi: rtlwifi: fix memory leaks and invalid access at probe error path
Thread-Topic: [PATCH 3/4] wifi: rtlwifi: fix memory leaks and invalid access
 at probe error path
Thread-Index: AQHbPQPvGI3apgA7bE6azJJ25/05S7LKs9Ag
Date: Wed, 27 Nov 2024 06:38:41 +0000
Message-ID: <feca8f91439548aab521c52fe29155a4@realtek.com>
References: <20241122172718.465539-1-cascardo@igalia.com>
 <20241122172718.465539-4-cascardo@igalia.com>
In-Reply-To: <20241122172718.465539-4-cascardo@igalia.com>
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

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> Deinitialize at reverse order when probe fails.
>=20
> When init_sw_vars fails, rtl_deinit_core should not be called, specially
> now that it destroys the rtl_wq workqueue.
>=20
> And call rtl_pci_deinit and deinit_sw_vars, otherwise, memory will be
> leaked.
>=20
> Remove pci_set_drvdata call as it will already be cleaned up by the core
> driver code and could lead to memory leaks too. cf. commit 8d450935ae7f
> ("wireless: rtlwifi: remove unnecessary pci_set_drvdata()") and commit
> 3d86b93064c7 ("rtlwifi: Fix PCI probe error path orphaned memory").
>=20
> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



