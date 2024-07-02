Return-Path: <linux-wireless+bounces-9852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E9A923E21
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4065AB21BB4
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE21B16DC2C;
	Tue,  2 Jul 2024 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="coy6VasB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00715689B;
	Tue,  2 Jul 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924638; cv=none; b=oLhEorqS4MMwb0M2uesEGF8b112uxhsGmfYalwxk/FHPBrAj6pHACdnWOrPZ/IDs1t5xV3JOcUXEplGwfke57DEoLvyziKGTmDCivb+keIWccr9Iop9CBry2P9ZJec5CeAQcLmIOtfhY2MQS3vlOXVtSNJVEXF2/cpkSI+F+5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924638; c=relaxed/simple;
	bh=wZ4ce2/JHQtbnvdZNkk2cs0IMP+Jit6BbiJX6+NDK44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hr0NsKHugdykzlxpk3LaQJ7lpndYXmWAbtpX8YuWxTGQ2AytWW2/DyfgagoQGN9GM7Cqw8t7Eye2J9tynbTdCzMnaJrpFIzrxvOJzbOS8eFZ3QJuQ+35g9XC4XGRMv1T/bDzBppm3WzYhO9r0T+c1Tramp4OjS5XsdgljzwhG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=coy6VasB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hjgeQkxHClGKMnLDtElE5OXrX6B0Ogb3jMe/A0TWZuI=;
	t=1719924628; x=1721134228; b=coy6VasBNpsYbku5gYtDtcIbx1Xwar2MdsVvMfINWQDXHWv
	8gHtyfchLulGD2y+280qIlIhzJlHS/81thKqBympGursYWuFKx0N2P8vU9cqi4uYXCv2YeR2U8qsv
	d6CZFC9PmqqnmuJ7fMSPnDjHnfBwd7pePDC1OD0srB+yJPR+lDssbUJAhkfsx6S/mZYkvCgJeMM5K
	nRVgSXG4B7YBym0mgy6iDKwjGY7AsjiiAgIBh2tykni7Z6DtxXwIbmwKGoiU/WOP1tDRW5JD8ZIru
	GFIm716v2LSFd3hcW+IVKrOF2DdzJpbSojyFuVseWrXf1FanTwJERg9LIHrdmZ4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOcwr-00000005UvX-3u1H;
	Tue, 02 Jul 2024 14:49:30 +0200
Message-ID: <2db23d6f3bd62c955c76d30aa2dfc3f03c8c5748.camel@sipsolutions.net>
Subject: Re: [PATCH wireless 0/9] wifi: cfg80211: avoid some garbage values
From: Johannes Berg <johannes@sipsolutions.net>
To: Su Hui <suhui@nfschina.com>, arend.vanspriel@broadcom.com,
 kvalo@kernel.org
Cc: kees@kernel.org, a@bayrepo.ru, quic_alokad@quicinc.com,
 zyytlz.wz@163.com,  marcan@marcan.st, petr.tesarik.ext@huawei.com,
 duoming@zju.edu.cn,  colin.i.king@gmail.com,
 u.kleine-koenig@pengutronix.de,  quic_jjohnson@quicinc.com,
 linville@tuxdriver.com, pieterpg@broadcom.com,  meuleman@broadcom.com,
 frankyl@broadcom.com, stanley.hsu@cypress.com,  wright.feng@cypress.com,
 ian.lin@infineon.com, chi-hsien.lin@cypress.com,  zajec5@gmail.com,
 antonio@open-mesh.com, franky.lin@broadcom.com, 
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
Date: Tue, 02 Jul 2024 14:49:25 +0200
In-Reply-To: <20240702122450.2213833-1-suhui@nfschina.com>
References: <20240702122450.2213833-1-suhui@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-07-02 at 20:24 +0800, Su Hui wrote:
>=20
> Su Hui (9):
>   wifi: cfg80211: avoid garbage value of 'io_type' in=20
>     brcmf_cfg80211_attach()
>   wifi: brcmfmac: avoid garbage value of 'status' in
>     brcmf_c_download_blob()
>   wifi: cfg80211: avoid garbage value of 'noise' in
>     brcmf_cfg80211_dump_survey()
>   wifi: cfg80211: avoid garbage value of 'chanspec' in
>     brcmf_cfg80211_get_channel()
>   wifi: cfg80211: avoid garbage value of 'freq' in
>     brcmf_cfg80211_mgmt_tx()
>   wifi: cfg80211: avoid garbage value of 'wsec' in
>     brcmf_cfg80211_reconfigure_wep()
>   wifi: cfg80211: avoid garbage value of 'wsec' in
>     brcmf_cfg80211_add_key()
>   wifi: cfg80211: avoid garbage value of 'val' in brcmf_set_key_mgmt()
>   wifi: cfg80211: avoid garbage value of 'wsec' in
>     brcmf_cfg80211_{get,config_default}_key()
>=20

Uh where did all those line breaks come from?

anyway all the titles are wrong - all of this is brcmfmac, not cfg80211.

johannes

