Return-Path: <linux-wireless+bounces-8850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FCB905037
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139C0B2124F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69B16E87A;
	Wed, 12 Jun 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZowhKtiv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9D62576F;
	Wed, 12 Jun 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187287; cv=none; b=LeXW8ovPxxOzzetfs8Y2zOYXQ4S+ncg9WwU0IjaC89J90YUPIFE6ORdChsd7yNbk5y9m1FfRlsCs7Di1kRZelo4RNFDQmaZlj+pAEgO22MscQH36OkiLolc+x4r+4HQ/2rIu3KhuGVmIm4Xb7JYHOKXCim6frcH2kRCPK1pAyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187287; c=relaxed/simple;
	bh=F1N0NfWSGU2xjNToB7XxMF3lDRv4WElvZ+cfjLMi2Zw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sa0hWAEaJhH7f6W0D6hZZipS/dCYe2Qjg7py78pHwqx+GJkw/LST70N/uewBEGGwTOzEHQDQzV2Q2FiXXi1Oh6iueP8w7TqjbwZljuRolhemYSPb2kSvu7UmzXfpVDC7z9gQuiFz0OYoX3EHHImBDBmfg8N6Bcv57n775abZz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZowhKtiv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=F1N0NfWSGU2xjNToB7XxMF3lDRv4WElvZ+cfjLMi2Zw=;
	t=1718187286; x=1719396886; b=ZowhKtivNLhfXneHCRFJtIEPtfuOo4gWWSvJNajL96gyC6h
	7jpOK6oU2xk5puxvSzuFT3dw486yoa94wNlBwcKgJGyKNJ5k40PNXuKliK1W+czcnRgCLBnWPY9Ac
	pd85CjuMOGdx1sfUnFL6XiIYaDXpmXdJiAlVmPm4dOmszrPd4N46Kd3lG0hsTTCMFlqe1UgCtq5xU
	Bo1BKszTS2MRTjohKY+c3j+5+Ug0IH6ByX2SceJggrveaVrZEEXdgUyJvRnZcKqP294kz5SDHJnpX
	yrZ4itIz/lo81Jzt4jJtNb/7QryIGkMPJa2vgPxUBYdu2NCm9IPMi9QHTAX3RQEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHL03-0000000A9PT-0srd;
	Wed, 12 Jun 2024 12:14:39 +0200
Message-ID: <42e6c6ec01df0de6c1bf8b7610758d0f1ef8ae7c.camel@sipsolutions.net>
Subject: Re: [PATCH v1 1/2] net: rfkill: Fix a wrongly handling error case
From: Johannes Berg <johannes@sipsolutions.net>
To: quic_zijuhu <quic_zijuhu@quicinc.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	emmanuel.grumbach@intel.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 12 Jun 2024 12:14:38 +0200
In-Reply-To: <9ab68c04-b33f-4f76-a563-2bc9d6c01401@quicinc.com>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
	 <1717771212-30723-2-git-send-email-quic_zijuhu@quicinc.com>
	 <5d901b213389c38eb5bd1df37cb8a1c3d82ebba5.camel@sipsolutions.net>
	 <9ab68c04-b33f-4f76-a563-2bc9d6c01401@quicinc.com>
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

On Wed, 2024-06-12 at 18:12 +0800, quic_zijuhu wrote:
> On 6/12/2024 4:15 PM, Johannes Berg wrote:
> > >=20
> > > use pr_err() instead of WARN()
> > > for this error case handling.
> >=20
> > I don't see anything wrong with the WARN here, it's the user/driver
> > calling it completely incorrectly.
> >=20
> the function is a kernel API

Sure.

> and it is handing invalid user input.

No.

johannes

