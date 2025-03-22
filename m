Return-Path: <linux-wireless+bounces-20689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4DDA6C8E3
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 11:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB457A87B5
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8F11F03E4;
	Sat, 22 Mar 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uETpm1M9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC741C5F1E;
	Sat, 22 Mar 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742637703; cv=none; b=j0QuqY8z1Gsqvx7FU5ByZo/PSZtgu6DvnyuIdarkN7jeDE7VipRZhk9khDiQkrqTtHGD2Gpd8IHjmVTG7VzkrpjSLpChxprSxcCQzdC1FcB4rzTEozwjh90llilYXCDWrNg7h0ON1FxWC2Ccp6fUQz1GpH7ZJH6oQZxG+EDmvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742637703; c=relaxed/simple;
	bh=txmZIfvv6iXfG6OLCUXMRADhVq5/Z4TGecvHiP/uPVo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KhMyqUzuTugAFzUbUgjPd/5KY9vFBbh0k7EfEO0onfdpCpEedPdhtdjCYtXllAxdZbrSjXrnLvbs+XZ5fquDzSpoYkqYG53KrZVUgztYsWnpvCYvuQYhm9yLSxfU3o6gYpFGwc/Fqhk2qKRsPpFqFFyCZ/63ZIJ1M7b+pWYLDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uETpm1M9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742637688; x=1743242488; i=markus.elfring@web.de;
	bh=iAEpjrSv507710jqRh6zdUdBI0yMAqXScOhii8Wavfo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uETpm1M9BwO3VTF7XVDXSoT97UulAaZRSAUWy0X0UNVwA6AQLxBxrsH8KBZjRXN7
	 r5q5aYxbryyuGI3PuMLc6M686mh32BmfGjuK78FZuryjuzYVEV/56Zt96+wG/nx8B
	 Hv2cv5X+K0crz0ucVDOzWncRsYRT0BaTSkS0iBuo5ugKx4UYB1w44LZScCVRL4VYe
	 3UU6Z/5BDIwneUrw7oFy0uoLoMed5G9lILnLpdOVCRwyGckREmOmKdmkm0KYeA9SF
	 qtGNoJwL/NmIPf0agCdgw1EkbrvQPIMtLV+SMg09vb2Ueh1ogzBaTpoDNGe1zfV8A
	 1FKMltss2bKOxAWwLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.73]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJnX-1tyRpB1EOv-001Fe1; Sat, 22
 Mar 2025 11:01:28 +0100
Message-ID: <061ebbe3-557b-46d7-acb8-308ae87105dd@web.de>
Date: Sat, 22 Mar 2025 11:01:18 +0100
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
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
References: <20250320201914.48159-1-qasdev00@gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250320201914.48159-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2McX4CekldO+dCShfVp3nTTN6ebmKzksWZyPGWUnWPaMGAAp0mb
 VYfQxcDdow9Nxrcn84qoj1thGy581LDB1hSfhFBfIC6mnjGy9/KPgMp0zmaqR6xxkb84TSO
 Xj41wDMvD+Sn3RoJLTrMBiy/03IFIMX5XORul19XLAW/RWdmf6M2Zcpt9diAo8M/+o+o2Vw
 TB4yqtQemP28jUy1MHX8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZLMBFJ+Ezhg=;XdhfVc17+G6mZHDb0rrzWwQSBPY
 JyGwU2AIeGvJHa5/dvsgMUoXpLSoLtiCWRM4en4UXlVptT75+W1Ui2QqZwyFso53cMT7rD90T
 oJuRdQsIdBFcC7xyf/ohVt+IhTG00r/IcXTkdFHJlpkgVeAeqlIk8SZUr9C8K8R1VUCZv1Vmw
 8Vmneq1nS/ORSlKGADbeIPuR5n+3cXqlCTgiOYrY27vYYshGG3osluR21qktOFVd8uBtsCWYZ
 Ylw6F3Z1onm5syJIMoCkQpGer4+e0uSQT633n3vjf08UnGQkIV88Tm5h/hw0GgQZw0/56uDUI
 ioeokjERcO3kUQuGCzy7i5Mv2PkhZg4I++luxREzEaA2whvAv/o3sh7yRHZmoSZBU9+DzHPsa
 1jV3invEdwYD9eVV6zl9RgZoubyxzUHEJniO2N8mlIrx2GOTdVvBbiJ/mHwb0YUTY6x1eVSBQ
 KH3prczrDY0KGAb13xdEPQ2x0mN6DXuYLdrD/ZQlB0Re8VouvMH7tDyABDWQwq4beOJ1qcFVn
 35zHeHCQM46TFeP4RYqvnFB4lsRm+P/30G9Z6zsnysQVYqa/4Yj0T8tJIea9xYNhCnEcZLsMp
 qanxmGs7aViFmyfPS6t/fkm+DnLCnr543u0V3Iq3jc2TguXFRpVY0W6RwjhWpK19G5e0qH0QY
 Yy+3ZhUPd2KK6jv6JgTHlceXNEfk9d8b9wWTae9aSfoAetAxuDIFbPcJGjx2wdoi8eiulmk6O
 xDEqlWoNfIdySi2MMNKIP/pfR8+kP1l1O+N7C9y3WKa9xt+m3CE5/6aT+fPsl7ekOTMb66+0R
 iK5XdX2qOqe/YvNWTmgX0E5fiuVpORMAU691Hs1soguFgcMMSrybRuWiuaSP9rPXAi2AbKazl
 wBKfo8YM5ggWisD2to4YsnXOGIGS2ZsZ3+I8rIFSBqRKj9ifQW2bj7DLIEz+4tGZv3EpITQGY
 J528ccLeE/XOvAmT8BgpdwBU7+5dd+1SwbYa7VFaxjOfELQESC9qfQCNGAhQXi7IRyggKYD7/
 c4nAW1KSktL66W1vZbRf87BzhhYl9lDBLKsdHvSFXkYRrxs7zXgtdfPOGesak4+HiYjUrMibJ
 ii9N7VCM2EX4YaOCmHTX6g5E7Bvt3nRW8No7bJo73ZBk0wtVp/jL9kk75Luw6lNrSFM6Yjq+g
 YmebnzZmiJkNCIlDQwf83GkFaIZthU0JRfTu3DeQWd0004V1kInrWUz+rFlaaL0MOWfNqfdRu
 v6gPULtj2VcxcEQ4B/RuERfZMteYbPZsYG/IYy57Z5GIQHPsGTtNVsZ+/oJLnqGr4Hi3Qx4Ex
 PJrmiVJyE9fymePVetNSQupM4Tc5a6iq0H3Uwto0c+NZ2PS+Sf2ysR5EZ+fALpvqKAobQHQsd
 vMp94R9NWq3CfvulUpn+DsUOF3cgxiMLtlfpWQtHlAIQfGArlwoE6TxX7M9jHDPWyCHODXBFf
 sPRD9WCAbgCiYQe92s5M7ip/AjevWgwCoJufjCn/GoW3ky57i1we1wE5GMH+VQXFFhJRevQ==

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

I suggest to avoid such repeated error code assignments.
Can an additional label be applied instead for this purpose?

Regards,
Markus

