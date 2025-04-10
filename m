Return-Path: <linux-wireless+bounces-21398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19FBA84A2D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C320A189605E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F31EE7DA;
	Thu, 10 Apr 2025 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IJrJGm2f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2D1EDA05
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302943; cv=none; b=qRA+eXDbBcrzE44HlhnjGdK6h0RQmHviP6HLfDpegipuHHzenQ7b75bx2s5hqQ5DW7btjfoghnjU+Z7oYXS7XB3qm/61v1EN2sARU5gsJxoJFZ5INVRG9+aTdjAclKwBfOxucqkB2XK8YSjzGdcpA+wi8nZlRbW2XIFu9wqkgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302943; c=relaxed/simple;
	bh=oEj6H2GOJg8Va45U8qnHVQxsxC1u5kjYJpwUT1ublwE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sUSepgCkXTa9zmyrs9oLpH7JK5LzaqYCqh762IauPKM8MLpl/+erOPcK/91XsVYjtR+hsFNT3H3mU4SCEMjcTHVLsprqyk5K03pBX66l76+abCWWFPwYCuRy9iMW/1gBKnJh5mH55ayjm+9ThKvNK7gPrrrNbVoyB04AxnjuZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IJrJGm2f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ral71rj4rvBKVA11nc+3A0nqbPAjMwzZw59kJtLSjLc=;
	t=1744302941; x=1745512541; b=IJrJGm2f+smCEGbjSBsoWrlTaH+eKvIjb7H+TbyNSgE3s7v
	PYFpZwiXSsJorLFglIHhbVx3UOLmXHoUAk6O2Wlkg1bhDgX+8Q+EqN7dtDqEHDX85VQmdAyH/duX7
	vWqdft096pPXb6dd6Pv+/nvr3GqVFsx8aCMYThcgNBhsbLIq7wqCq7Fzumg2dlZjlC5Hb2ZDhWYh7
	5yEzDNJUpJDOcivEwN3EAkvF1wu+u9LU3WzfE2C7ZvxQDUJ4YYk/X3Nm5R+9e2Ked511V/qwDI3/2
	O6NEbqBRZu9/Ex/SryxonjS97Gmh92hpIoWyQJHXCNeZr0A2MXefsbMwYhjwdtyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u2usL-00000006Smb-2pxG;
	Thu, 10 Apr 2025 18:35:37 +0200
Message-ID: <47bb411b27aae5271a998fbb5a53c3bba9ab3957.camel@sipsolutions.net>
Subject: Re: iwlwifi: mld: Unused method iwl_mld_handle_tx_resp_notif
 (6.15-rc1)
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Thu, 10 Apr 2025 18:35:37 +0200
In-Reply-To: <13cac1e0-6875-c63b-2b60-70cbbcfd951b@candelatech.com>
References: <13cac1e0-6875-c63b-2b60-70cbbcfd951b@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-04-10 at 09:23 -0700, Ben Greear wrote:
> Hello,
>=20
> I'm working on porting some patches we've previously added to mvm to the
> mld driver.  Currently I'm looking at tx stats.  From what I can tell, th=
is
> method is not called from anywhere:
>=20
> [greearb@ben-dt5 linux-2.6]$ git grep iwl_mld_handle_tx_resp_notif
> drivers/net/wireless/intel/iwlwifi/mld/tx.c:void iwl_mld_handle_tx_resp_n=
otif(struct iwl_mld *mld,
> drivers/net/wireless/intel/iwlwifi/mld/tx.h:void iwl_mld_handle_tx_resp_n=
otif(struct iwl_mld *mld,
>=20

If you go by that you'll find a lot of unused functions ;-)

        RX_HANDLER_NO_OBJECT(LEGACY_GROUP, TX_CMD, tx_resp_notif,
                             RX_HANDLER_SYNC)


johannes

