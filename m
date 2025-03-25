Return-Path: <linux-wireless+bounces-20795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52EA6EDCF
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 11:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A666D3A64E7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E78253B66;
	Tue, 25 Mar 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yHgiuPRB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462F79F5;
	Tue, 25 Mar 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898822; cv=none; b=X0bUexvSOYU7lhX9SroUDw/p/2idblxNt9UbeUZhoovAdVWdJjPnFVAyd6PPdNlCjw5w4Os7B+InhUy3nJVhPMvnKtx6338qF5lU49bZWjN+YYbNfmW10qnGhIDEcWFryu7J+HY+zeAMueDoZ+ydTtRyS5K6xfB9haV634nGJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898822; c=relaxed/simple;
	bh=8MlHlktm9PBdFMf9Nxkh6Nsoqf+HfDwTdyg7XPwfpns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FughnH9H8BDmejFbUrK/GVFUDCMG48Ad6WscBNObku0ue0O1psVgEiJ0vrR4UWPVpdVTcEr7KE1jRPuXKVsw0NxS2oxqUlDjkN3CkskdgWnOgPpgxmV8qbpuWdTwcKMgEpGqZmT52aCZl+Qq2R2dWJNT8iUbvQwcsRz0pfwUTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yHgiuPRB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8MlHlktm9PBdFMf9Nxkh6Nsoqf+HfDwTdyg7XPwfpns=;
	t=1742898820; x=1744108420; b=yHgiuPRBF4NkVH1CRZjCHffo7ADupUiEN/PfEiUNR6189Bm
	4M8KR/9mzrRuHJBiYUnAkh/34aEvl0AFKeghkSeawXcBq+8hKMhlYiJSaELPUCcr4mOszWtwkiYtW
	t4QaZASE05tg0VmpL2AwDeWOMlF7NPJZ1mo+baz0qrSZA+A5gcVqduSYnHI6QyXIuwGjSNcRITaWe
	fFDZQhUnyCpH2Zr3ilnklqTS9Y41vLKlx0KLz1okKoa/W4TXB+ZzZ2o8rukTiSwmECnJggluKDqoe
	KJf/FxkYfwQzqbeX/BxiA+LgJwdgmmlmfOG+vVg3XvWxbrUPBJPCOlSDlam9epmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tx1b3-000000052CR-1hQL;
	Tue, 25 Mar 2025 11:33:25 +0100
Message-ID: <3452b67752228665fa275030a7d8100b73063392.camel@sipsolutions.net>
Subject: Re: [PATCH v5 0/5] dt-bindings: net: Add network-class.yaml schema
From: Johannes Berg <johannes@sipsolutions.net>
To: david@ixit.cz, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mailing List	
 <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Bianconi
	 <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
 =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller	 <jerome.pouiller@silabs.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Andy Gross <agross@kernel.org>, Mailing List	
 <devicetree-spec@vger.kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>
Date: Tue, 25 Mar 2025 11:33:24 +0100
In-Reply-To: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
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

On Mon, 2025-03-24 at 18:41 +0100, David Heidelberg via B4 Relay wrote:
> The Devicetree Specification, Release v0.3 specifies in section 4.3.1
> a "Network Class Binding". This covers MAC address and maximal frame
> size properties. "local-mac-address" and "mac-address" with a fixed
> "address-size" of 48 bits are already in the ethernet-controller.yaml
> schema so move those over.
>=20
> Keep "address-size" fixed to 48 bits as it's unclear if network protocols
> using 64-bit mac addresses like ZigBee, 6LoWPAN and others are relevant f=
or
> this binding. This allows mac address array size validation for ethernet
> and wireless lan devices.
>=20
> "max-frame-size" in the Devicetree Specification is written to cover the
> whole layer 2 ethernet frame but actual use for this property is the
> payload size. Keep the description from ethernet-controller.yaml which
> specifies the property as MTU.
>=20

I have no idea what tree this should go through, and you CC'ed enough
people that I can't figure it out either ... I'll assume not wifi but DT
for now?

johannes

