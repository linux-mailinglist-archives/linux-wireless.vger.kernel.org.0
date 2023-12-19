Return-Path: <linux-wireless+bounces-982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E106C8183F2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1390C1C23A24
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962561426B;
	Tue, 19 Dec 2023 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FtzeZCnc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458814273
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ud3RV2zTqIYPwMwz3ljDbg7bOj5/6+3N1aMJFhJTxLE=;
	t=1702976277; x=1704185877; b=FtzeZCnc/6s8q0OMFjSQgF7F1gnnmJOB+OD0klTxjefREUf
	VTRB33DzvK6yDGKYoJkir7fSKQZuCLZmaUen+H+g5+Klyau37InSmmQJ6Y7LRrF1N1CKm1cpmb/AB
	5TVrxQ9uKT+qYCUoQOOTqsiqtuPsl/1WZWqRwSkmGiHSiHimk/jDEEIJtZhZEdiIb2gBVpfjMBIlI
	roSM2U3oou+dGfnzQPy/JhAWtVQzOWSsEaJFfV1Z8DfKhTC0ZsyxZyNQW9RAtM2ZjF7k/SRHqGwYb
	cEotERnNyHjvlQizkDmDCLCXDYPnNHZbpK7fH7mEvm/tjx3HQZ6Ij6ZKvdvsA63g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rFVvF-0000000HVhy-2YAP;
	Tue, 19 Dec 2023 09:57:53 +0100
Message-ID: <19b41966397952fc18cb90346550eb3f2f03711c.camel@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: mac80211_hwsim: support HE 40MHz in 2.4Ghz
 band
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Jouni Malinen
 <j@w1.fi>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 19 Dec 2023 09:57:52 +0100
In-Reply-To: <20231220043149.56bf8f5cd373.I1ba6905c806be6e0548ed15130c0bbb2ee04c9fd@changeid>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
	 <20231220043149.56bf8f5cd373.I1ba6905c806be6e0548ed15130c0bbb2ee04c9fd@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2023-12-20 at 04:38 +0200, Miri Korenblit wrote:
> We are missing the flag that indicates that capability
> of 40MHz bandwidth support in HE on the LB.
> Add it.
>=20

Jouni, I had basically the same patch and I'm going to apply it...

However, it breaks two tests in hostap - according to my earlier
analysis, this is because throughput estimation for HE/EHT doesn't take
the AP *operation* into account, only the *capabilities*.

johannes

