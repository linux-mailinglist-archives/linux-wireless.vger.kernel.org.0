Return-Path: <linux-wireless+bounces-8863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147F905277
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954FE2823E7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E70916F8F6;
	Wed, 12 Jun 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=concord.sh header.i=@concord.sh header.b="UyqqOEqH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from komekko.fuwafuwatime.moe (komekko.fuwafuwatime.moe [65.21.224.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5214E2ED;
	Wed, 12 Jun 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.224.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195444; cv=none; b=NaU5G42Uptkg3nVZm/hRVRG2BQxzqLcMH1jrUWgEQ8EMriHB976KzOecHss2MIGjrTgV6B1VCSEkrmXAxxGe4x5IoGoiHC1aHHzRXWfHEe3/vIujaHBaQIYHUGEnAqh1WI5KhrRoLGTEgke/S/Qe+0Gz51uGCCawoFOri+O2Gus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195444; c=relaxed/simple;
	bh=aHiiNTWgtfeiuKP3SpXuVe/tNbTjnwll02QHrngVnys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIHPLDGpLZVEmB+O4IqSVcPFDCv/uYBrclVYtMOi7R3Nkar7vsJaHlAePaJ9lJPAl1bXpyqSPpnNkXkDC2vYbNy9VR7lECfPLHMIyenKA466wTqkKgNBBNA2jG5VasMc37gVcVmRNlmhwza3x+6RFeYDMUcPT5RuqVEKcjWLvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=concord.sh; spf=pass smtp.mailfrom=concord.sh; dkim=pass (2048-bit key) header.d=concord.sh header.i=@concord.sh header.b=UyqqOEqH; arc=none smtp.client-ip=65.21.224.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=concord.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=concord.sh
Received: from megumin.fuwafuwatime.moe (unknown [IPv6:2601:100:8c00:8960::15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by komekko.fuwafuwatime.moe (Postfix) with ESMTPSA id 6951D114510A;
	Wed, 12 Jun 2024 15:30:40 +0300 (EEST)
Received: from localhost (unknown [192.168.1.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by megumin.fuwafuwatime.moe (Postfix) with ESMTPSA id 233B010962CE;
	Wed, 12 Jun 2024 08:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=concord.sh; s=dkim;
	t=1718195436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHiiNTWgtfeiuKP3SpXuVe/tNbTjnwll02QHrngVnys=;
	b=UyqqOEqHnNcmGN2aeuDesIeJQCrizrK1vmt7eCpoO/YTTVgnRcbdhbmMpgcJJMrqNTBsoa
	DRLlbmRvNzRxw+uFPmYzHtGA+hkPjaPhRflIPczwVn0Dr8ZdrcUy7+OKWm+Y3xcZ9+LmpX
	6MN94O3CX1zd7xDGEMhF6olPS/KStk7rJEXoEmL1W7u/wrMcjKFGmrGXEuu0CYmEfowzwA
	Q9t+a8l7dYbF/tEExOj3hEQXKms1ZfbPDNZQPcysR2GV2+UqNnaMR5vm7CPHNpSgHwkNmr
	Ne5BxZAtg43h0Pl5JFaO/6NWIPLIhAzcj2YxJuMk+f0xq0/T/pxTwpjhgdREhQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=me@concord.sh smtp.mailfrom=me@concord.sh
Date: Wed, 12 Jun 2024 08:30:28 -0400
From: Kenton Groombridge <me@concord.sh>
To: Kalle Valo <kvalo@kernel.org>
Cc: Kenton Groombridge <concord@gentoo.org>, johannes@sipsolutions.net, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] wifi: mac80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <jzpyauk6kltqfs2iqtfxnlxdpddvxi6ir4ki3pmev4ol7mb36w@6zmleyr3zwmt>
Mail-Followup-To: Kalle Valo <kvalo@kernel.org>, 
	Kenton Groombridge <concord@gentoo.org>, johannes@sipsolutions.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20240605152218.236061-1-concord@gentoo.org>
 <871q5amn8e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qcauyrc6pdu2bf7a"
Content-Disposition: inline
In-Reply-To: <871q5amn8e.fsf@kernel.org>


--qcauyrc6pdu2bf7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/06/06 12:31PM, Kalle Valo wrote:
>=20
> In wireless we prefer to have the version changelog after '---' line so
> that it's not included in the actual commit. Not sure if Johannes can
> fix this during commit.
>=20

Noted. I can submit a new version with a fixed summary if needed.

--qcauyrc6pdu2bf7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEP+u3AkfbrORB/inCFt7v5V9Ft54FAmZplOFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNG
RUJCNzAyNDdEQkFDRTQ0MUZFMjlDMjE2REVFRkU1NUY0NUI3OUUACgkQFt7v5V9F
t564Rg/+L8KERRtqX2Bxp6u/O6LXz1QCDNwQSbINekkkJrL8w0w/VUKyn15x4ZQv
JsjfBYg7Qq489v14jikIY5ogqGwDRn7Z7fIBX0FTJh+RJ9Ex+n1ohYigh6PRBITf
pHVHPPym/y4kBDEE77YLWwmEjyEQA1GTV+GCkk8n+yk0q56Vz1P+rDMQ1keLjkcp
k44kctmij2XCo55AblJzNZzOaKtTKZMTurE6mTkK6EkLm1vRTPmaBBYbsjiKLP7u
DXTW3qY3+E6X3/7/NJgYqfks512eKbSfK9YnOY8QXNwMhaZaUG8BQOV/MxDYZImB
lQwQIMHUQS9ZwGnsRmnVfpn7vK9k/79tWONLXnEK2VxlgBjLP5EBYlYybBMulbP2
3W14gCc75zKWjav4KEpZvkd78SXQ8yk4PYOrXvFpybb87dOsv6XumVlEK0tS/KVy
p1EAQaQXyHAe0ZUTWIb5hqzYIpmY0xpzFgTzDxLJrVmRr3Z1XP49I477aR4z7IbI
7nJ8rjODkn0m/SW+6DGBWiMqOxnYBbCdRJuU+/9DISZW43LTDvMC5aS9esfupBm4
YAzZmIed+dmnfSJmkbIiH6FFNyT2owUMnyTlQeybSTwDTVz0mziHOE/FqGMMzeFL
n5026WFp/s/7/p2BX9ckA5lJMygQWpjhcBJFPw1xqqpMIA4WJgc=
=X+yb
-----END PGP SIGNATURE-----

--qcauyrc6pdu2bf7a--

