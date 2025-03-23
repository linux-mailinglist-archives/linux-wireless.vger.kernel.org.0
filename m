Return-Path: <linux-wireless+bounces-20716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5CEA6D03A
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 18:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10397A590E
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D11912B94;
	Sun, 23 Mar 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="euWeTzGb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AF72E337C;
	Sun, 23 Mar 2025 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742751074; cv=none; b=OzDbv55BYpsSBcbFJ3kODxwNh4bZ3+U+wbxXbxLOg4Kkm8X27J7v4B2XBHqczzDq3mYMJWLF8qtCsFq81mwi+yQR7E2THpgfgP//KFI0F/wRL6EA1Jo0Ttbr6K8rznF82LgkRIxnUDUI5SW4iwKEFaKVqxS8kRvTjbgipdsNgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742751074; c=relaxed/simple;
	bh=vwsOFT8e65u6N+CcNPlcCQQ3RjoMD2CoARpH2XTneHQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aJD7vk89FRfMZ1EwVZTyzFisKgAp6FvGWt53RzSA32w/s0lln4WJOVfF96Wagrsl9lwAmwPYgps96lO9yM8JkkL4v6/jIPTP6c1CW/n5NRoVMle2siuWEozolNTvjPh3RsXR3+HFvYBwfIuMpOdUXIWdS5Kc3jaXd5xVkxWE4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=euWeTzGb; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742751057; x=1743355857; i=markus.elfring@web.de;
	bh=aS26mjbyN4abFalJdzaoStx6yXU3U8r5tdNKBbcsZHU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=euWeTzGb1rN8KKZiRijlg7gIUkM7JDUBfjL1gr+b0UK6l43xtJPFUz5CA95xrbCS
	 MIe3kTPEEi81izfL1fEKwQgl6WArlH+zRuqSABOKbHDWSDB6lnT7+78msDp52/rLW
	 iBjLCyZIdPSjolVmPV6siFilCy+spFpHYLmES7RJZPUE0vZfrELG47MweIOpyycCt
	 GX9ELDgPqjlYRTpZoYO+ChKDY3UIUXUHwcq1F6YExWJsK7jLMYKkeTVK53y+Q0BJ7
	 RHVNvNjXfVeo3IHHbnWIIv3Fj10sXgDYm+vbWYcL8EV/Y6Xi8c9vh8LLVKG8CFln0
	 Q5W8brIWphi+HhXLyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.71]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxo5-1tl4ju0s23-00NkmL; Sun, 23
 Mar 2025 18:30:57 +0100
Message-ID: <6a45eb0a-01e2-4316-bbee-93bdd490cfb5@web.de>
Date: Sun, 23 Mar 2025 18:30:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qasim Ijaz <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bo Jiao <bo.jiao@mediatek.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Felix Fietkau <nbd@nbd.name>, Jonas Gorski <jonas.gorski@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
References: <20250322230137.28164-1-qasdev00@gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250322230137.28164-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mGNn0js7md32cTCJEgqZPPy4hyHljtu/hoMlFhXvzLekJuVU0Tn
 ubdLUleIlTmQ7FNQCSSLtPk3mKbVE1DEfbxSLB79BnUzj0ur97GHBQwF9EHV/i7KatTE6dR
 eTMGxaSKsHq6n6QcuxIs0sng4OWxo+1OkswkNWIjZaGXDAReJwO99DSIX357yW9zouy1SrU
 BoE2zwzo8r3hXOcR1nTOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1mKSqeyZi18=;W19U/1M1dA8MGB8usvwUxEXkLrA
 nX9et2qPU3TAVk6+9MNSRQc7tbID6fWCi0D4PfbYdhhiIQ1oSZEebgUpwfjDM4PR93C5jJhEP
 opfXC85UGKH/Io5S82p8EF5KmzLv3i+o3ArlcyvLHaDClTwhKowH0CyUOAJvS/skGk9wGBvNW
 Apt8Qi8092gawnDgyx7+fWk+Sn659QJhBxdTFeNs956DBuJub14R05/8lPYyyn7XieEhHvJ9Q
 D7q05Bj+5ELl6touPRVUeUZ7dZbAJfh+CoHpgIr34/1J1XHwhrRC2dW7qvOvn1oUeKkP5uacD
 id5Ry9xhNomJmnYViGiHAZS+6psqWBc1TisEhNkYPBK1ggSARrjA/E0IEv2La7irHVolti+im
 Ju0Bv0TaNTuqUMKLDXaMVgpFqZjh+v5LmiS963ludUk10U9iny/76RWKFi62nmb0MomEA/Fdk
 A2S9ZDalutNaPAPllTItGKLaCcHt4noqFjsk2oUllAUsBh1p7Vf1SrDtBBSLIdLHhYSMrTOMJ
 tPtGTW+4YuFCAkG3CtXnNycKYzjANaEsapwMwZJrg7MKHCsZNctZnywCRdURarhMV32rDkwmj
 6leNKcFSfy8uNy4zhkHFeLEKp585UpENSzgWC9iWTh4BidpS7/O0+bHlWWjljuLWaJ/v9j6ba
 E1i/7C5Mxxajxa+A3U1veEDXrfhjYjP72q4NX17/0D4PQx+m6uM2evxyMEKn7Z1FqgpvFqbVP
 EOMOgVSSIBdGfkaHLrFqd2Z12XaRlhlNMDrTQiN7+d4FEJKoeL3y+wfgKcpQl5GRurIuCxzp3
 GQHNyWiUynnWCFVBeQSlrJqDNZIWRHkFAEf6Td5ZLb0dHJ3Rk3D1F+GfxWX2Odf6kGYpefxB5
 /KxjvhkMxmnnG1JOPQ+oTMP8lbGtELlxogzvDh+aRuQvSJFA8gi4Qn823ts8hKiWzwGlL0ofs
 et/urC/Dh8Q1J46iFNE1I+M8apiX1DV1VFjpoN+MnhF/7YTFssXLtZdHIzfMJeGMHAZ6A+sJj
 HNXVW/krAUfhEuFvrtbMk8ruB2xPFYPqSZJ8nckIBVmJ0kNv73Y/qwdHTCDjXGGiGejd0lAVb
 Q0Ii60fhYvLfYY4JIGgatWLaZW9wsJfs2892vPFai1FUffWGi4ydcjy1PtNG+fHJ08sSmKrAr
 o+H/z5LnthVDCtelaevV8Vhm1P0KlM6bvXBLn5NkzB0h+HALG/0Bh/CMHTk0lnDw7UacTN+Xz
 0GrP/uXKvuV9SpgEr+fXjbKHB7i0JOPS/r1hDdOTGKL3YOirQvHVnLDGIRow7u82hYAvtHqDk
 OBnpau6DdgRyjn6h62bN6ZqhQCwC3O52ZgIlNJUUnceydse1LE0LO0wjqOMRc1t05NO6Ggkzo
 ofdzDtHsPegqzSFjPOaScufqL80/wB7fKk9zI7DdO9H91BRuGGEzFtn1M06wAR1sgpAnr/c+e
 PwnO2hzsS/4PaqwdgPbsmJDCJixtXFVD+na45TtlnprpYIOC+NdXl5v8LKgLBi1jWiEZc2A==

=E2=80=A6
> or link_sta_dereference_protected() fail the code jumps to
> the error_unlink label and returns ret which is uninitialised.
=E2=80=A6

* Would you like to avoid typos in such a change description?

* Can any background information become more relevant for the usage of
  source code analysis tools?

* Can the summary phrase be improved also another bit?


=E2=80=A6
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, s=
truct ieee80211_vif *vif,
>  			continue;
>
>  		link_conf =3D link_conf_dereference_protected(vif, link_id);
> -		if (!link_conf)
> +		if (!link_conf) {
> +			err =3D -EINVAL;
>  			goto error_unlink;
> +		}
>
>  		link =3D mt7996_vif_link(dev, vif, link_id);
> -		if (!link)
> +		if (!link) {
> +			err =3D -EINVAL;
>  			goto error_unlink;
> +		}
=E2=80=A6

Can software development interests evolve in ways which might make the avo=
idance
of duplicate source code more feasible also for affected error/exception h=
andling?

Regards,
Markus

