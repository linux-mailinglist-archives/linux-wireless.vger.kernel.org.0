Return-Path: <linux-wireless+bounces-29224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC779C77801
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 07:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0314534A451
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 06:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692A26C39F;
	Fri, 21 Nov 2025 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="g1ymSDUc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B61F5617
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705095; cv=none; b=eoCU0XNXnrKM0c8yW1JzBxL9wWkUowwSETK9h6kNnQ1KiP7D1qpJUjd8YSJskxUD0VvHeK+EoSUX2zRvGUnpHSn/x9e2EZhUgZWjk6Zb2qm/ngV9zuZlC69h7V6nKHO+ZBro0OgN3JLNHVwEfonLJ+/yQ50jFobm4QDoor1vYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705095; c=relaxed/simple;
	bh=ZromAkvc/3V8mgNJyWR2OrHc1vzSS5Fv/EMkcFtHges=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E49XdtX3CVKKmrFqWpdSE5jN9z/z+M0cdp4hnlnoelvxEv1McM5cnbUbE57ZE2XuL89vXQYq4Hu42Mmx/B96c6FrSFzyfQIfWtcB8dXeno40anMjQuT2IRYJ/YZnPcMyZlvN5jn28EV4Q4TdeImUEvDsP7PCHntbulLtoIp2qcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=g1ymSDUc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AL61swwE3030759, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763704914; bh=fsn3yi34vFL6wAN0Oy9EVsb5SXXk0AlVm2ngOvpfyQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=g1ymSDUc2XnpItiFt1mLtTcVL2qynJILZyNh+cuVceFHQ5NejiT2eFGrMqVKsa7yW
	 Y63xkKyLwo7dOOgCYQCAEmrJeSluKUd3zfuolXnDP0OCJBL3cs8YcPo3xd7NdszYqa
	 /UjHIKXErxW50bySB/6PjSNOxfBy0UyfSLRqZwyK2aeDa/79L+uZOUonv2rJ3Olnbq
	 OLXeTEKgec9RfTrdULOzuFPyOuXopD3BCWudYA0duLSfN3EkbUqL+oz+sCCzt7o/8A
	 Kb2MW5U4omC7SHveGpNNBBddv5kQA7fnkAjrEwz64GW/vKWql3LaP6IRLcUm2lbhfe
	 9/OUyDPPOMFpw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AL61swwE3030759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 14:01:54 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 14:01:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 14:01:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 21 Nov 2025 14:01:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "nbd@nbd.name"
	<nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>,
        "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH] wifi: mt76: Strip whitespace from build ddate
Thread-Topic: [PATCH] wifi: mt76: Strip whitespace from build ddate
Thread-Index: AQHcWjgzLwwe4dMD8UutouPxvuwR37T8o4bw
Date: Fri, 21 Nov 2025 06:01:50 +0000
Message-ID: <a29d737be885490586c30be6262835c8@realtek.com>
References: <20251120155829.3494747-1-superm1@kernel.org>
In-Reply-To: <20251120155829.3494747-1-superm1@kernel.org>
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

Mario Limonciello (AMD) <superm1@kernel.org> wrote:
> @@ -3124,8 +3125,11 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, =
const char *fw_name)
>         }
>=20
>         hdr =3D (const void *)fw->data;
> +       strscpy(build_date, hdr->build_date, sizeof(build_date));
> +       build_date[16] =3D '\0';

As comment of strscpy(), NULL terminator always presents.

 * Copy the source string @src, or as much of it as fits, into the
 * destination @dst buffer. The behavior is undefined if the string
 * buffers overlap. The destination @dst buffer is always NUL terminated,
 * unless it's zero-sized.

> +       strim(build_date);
>         dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
> -                be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
> +                be32_to_cpu(hdr->hw_sw_ver), build_date);
>=20
>         for (i =3D 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
>                 struct mt76_connac2_patch_sec *sec;
> --
> 2.43.0
>=20


