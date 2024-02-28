Return-Path: <linux-wireless+bounces-4132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B368586A701
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 04:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539A01F2C748
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 03:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223451E86C;
	Wed, 28 Feb 2024 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="MltQJ3TB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6841E87F
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089404; cv=none; b=N2G5jorsy81Sk7Si1EFDFqorKhgNdIJKVfegrVRYFLJ70osTr4xezAqLbZIpqRpS1C/1dgpyHvBDzIAInRWHK+ul2KKg86VVMzAapfo4IltM3lXkmDPNR/Pls9YS71qeTw7q6u4qxjPvfJz+lyuKPSURzbtFEfUxu7UPOsFw804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089404; c=relaxed/simple;
	bh=y12k4KVgD1oGXRTDF3s3fpg17KRkaH1E70Z/KIc72ig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mscj5A0vUoGUCizzy6eIeTMvz4bXQlLPuWr4xmluD+pM7p6C0/9MxMpc10vLNpfHPRFedTHv3WYj+ZtXZuV0OcwVksZY3MSYdA2NFyGYyNZxRV1+2naPGE1jmeFSZAKwWbMINaksK9skXonK2zMZh7rmMT+rwnH25pV0l7dcaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=MltQJ3TB; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709089379; x=1709694179; i=s.l-h@gmx.de;
	bh=y12k4KVgD1oGXRTDF3s3fpg17KRkaH1E70Z/KIc72ig=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=MltQJ3TBj1jaYI22KfrAYzg6YZRG5ydhNJyf6+kZRAWl/evbm/ekKfLDm5Ar+iZu
	 z/RwqEEeFKgYqTUV+Yh3eeos6h/i8odW04wLTTg03DSimGoons+MPpC8t6BSz6XiM
	 beZQNHWcj8wKpkcNCahZR+XG6ezxgU8miX5YN2pNWFWG8MwhKR0c/HrOhtUFoU2pI
	 F6wdIUmW7rV4gjaBKN0OWy8Ap+QymkNmMYR61sMfbCTBklIuwYsPNcx4CAKMVNgxY
	 +L0cCZCWMK4MUGqD92K0DN5aFeeIkndlD73/84MO2GhMYIG/JZgVFeh9phXQb8Tkh
	 fc0Hgx1mkl3KiY1dOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.82.155]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1rLzAz1SzO-00JKFB; Wed, 28
 Feb 2024 04:02:59 +0100
Date: Wed, 28 Feb 2024 04:02:55 +0100
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Jeff Johnson
 <quic_jjohnson@quicinc.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Johannes Berg <johannes@sipsolutions.net>,
 Ajay Singh <ajay.kathat@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-wireless@vger.kernel.org, Sergey
 Matyukevich <geomatsi@gmail.com>, kernel test robot <lkp@intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, srini.raju@purelifi.com,
 krystal.heaton@onsemi.com
Subject: Re: wireless: orphan qfnfmac and plfxlc drivers?
Message-ID: <20240228040255.0932ba6c@mir>
In-Reply-To: <87msrmj9c8.fsf@kernel.org>
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
	<02c155ff-f880-4e88-b600-9d632019729f@bootlin.com>
	<875xypejwt.fsf_-_@kernel.org>
	<871q9dej8j.fsf@kernel.org>
	<89bc5ff1-b049-49d1-b15a-4e01a4659c74@quicinc.com>
	<87le7kda2a.fsf@kernel.org>
	<21846c39-b5c5-482c-97be-51e36e1ebf49@gmail.com>
	<87msrmj9c8.fsf@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mkzM9556EoESYCJiZiWZJ+aYt1Swu3QecEv3lWpTmGDWFz36agI
 uabAp4I439ipChasA9Xk6/6y0vsH4g/Q7354b2WTYs8ZkCBqVA0sbKSw2rbbkHv3LK+Xcu3
 9YQtJzUKiaeN4r9OQxTJosdZ0aGWgGdyaoer07wsPuCZtIbrVVPurEp0SBkyYimlRXo9dyv
 P8HwmksYv1BWU6UB0Odcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1F5MHQvDhLo=;8dycDLxn9QJ1pc5tbUDLuwoh4z0
 AlIZ0CTnEz8LhWaoE0hSuQ5AB4msk4eLfp0ETu+bruqS+4Ej7SUNiI2+Yn6qEBZOiSgDQijkf
 SgGAbqbCQjCPyz11Byd4Hcw2KfnKYoBRw42h/nNz0gWd/L+0SrmQ1xFwrb+IDDQ1MA3P+koYw
 PoZzhaCPExPBiHQiWgcpz5wUZNmPJpkTSLjwhPfSRzAAzWNrO1B+K3dYSTINYCvpJNoGV+uSv
 WbNUbTDxt5OcgUOaGe4Y2CQa3syNGNpV1mebKiF0aRr88cgOdU/pzi5p6r3srrN0QuW8E8bAw
 wOaSaiVwoKI3RPyEkMIgYy9aHD9D/MnV4+8XKs4b7+Oz9KZzqkr8ROMYuJMG7gDz9ycdSCcQR
 HnnESAXqgClAV1tZayyWqgVLwp4cLnSOaYvk9tEaBxzKb/3GlCzWslqghe++yzdfadGq1AWC3
 CrZJw+gZJSOZhfSzEhV+jUUaNGkQaIqL8W/wMndR3DCAOfdCUmgHKhwHBR85stRSppBnh4vmV
 PHIdTJbKw4zBD1yS53n1Uks2GSub5EEHCEfjuLqMt8aw+kZVMxt41xlj5+1nOH5hZgg9qHKZX
 jNyN+MFEQRHTr/GzFX2CzURMPiRtwhkYLXtay+L4Tk36vMBPiU4Bj6wCkfNbbbBO/mHEPDbGD
 XYGqN5Ft4jgGVJDdnNDp1NLjKLSoZs/jkqKffoAl53fQzLASFOM1N3SzwRdL6ekb6EWqmmZlp
 kZ+2e2/BSYZKCmE3XxSEtUhAn73T9af+6CbzyrEnLcdaAZwQEWWDrMSZjgQicDaADR8q/0Cj2
 A1L0+43q08bjBpm+iwXUzkX+WKgRY7OVLd8fqeVMVJos8=

Hi

On 2024-02-27, Kalle Valo wrote:
> Igor Mitsyanko <i.mitsyanko@gmail.com> writes:
> > On 2/16/24 01:37, Kalle Valo wrote:
> >> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> >>> On 2/15/2024 9:21 AM, Kalle Valo wrote:
[...]
> > that's right, Quantenna division was shutdown by ON. To my knowledge
> > no users of qtnfmac drivers are left after that. I would think
> > removing driver altogether is the right approach. I'm not associated
> > with ON anymore so it's just my personal opinion.
> >
> > CCing Krystal Heaton who I found on ON "contacts" web page (just in
> > case someone from ON wants to comment if removing qtnfmac driver from
> > Linux kernel is a concern).
>
> Sad news but thanks for letting us know. So unless anyone else objects
> the plan is to remove qtnfmac driver in the near future.

In theory, there would be quite a few /potential/ users for qtnfmac
and QT3840BC 'Topaz' (QSR1000) on a variety of early 802.11ac routers
and APs (particularly on ipq8064 SOCs[0]), but as the required qtnfmac
firmware for these chipsets has never been published, there is
no wireless support for (the typically 5 GHz-) "Topaz" wlan chipset
on those devices at all.

The devices are out there (albeit not the most common- or long-lived
combination), but they never had wireless support in the first place
(first because qtnfmac didn't support QSR1000, after that was
rectified[1], because the required firmware for qtnfmac/ QSR1000 has
never been published). It's a bit sad that these never got supported.

Regards
	Stefan Lippers-Hollmann

=2D-
[0] e.g. Linksys E8350, Linksys E8400, Netgear R7500,
    ZyXEL NBG6816 (Armor Z1), ZyXEL WAP6806 (Armor X1) (on mt7621)
    [Disclaimer: I don't own any of these myself, but I regularly
    see requests for Topaz wireless support on the r7500 and e8350]
[1] Tue Oct 16 10:23:58 2018 +0000, qtnfmac: add support for Topaz
    chipsets
    e401fa25cfa23df8b17960a656ff11f49facae84

