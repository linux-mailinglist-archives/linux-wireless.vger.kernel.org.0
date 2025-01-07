Return-Path: <linux-wireless+bounces-17136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE409A03A63
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 09:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A31885E74
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC0E1E0081;
	Tue,  7 Jan 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iH/Mg+hD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64041E1027
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240322; cv=none; b=On94x7RhrjrRBNLlB6Tq0YzM0u3+dyVGEfI7ZPJhSWo/BvXMhbETWZGS7lbuLPjukKCt4UoZgF66F/ezLq08riFWOG88EjGquXEh5YOloeG7oedxYtPbjqg+uy0F4AN1B/slU14bU4JrvM8gZp0Em/MP6VOuhM5DgjOMeoe3joo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240322; c=relaxed/simple;
	bh=jbzyILUlZ7hG4+xGsnn51fl/LmI36mStfjSChc71Wpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Osk0BBdjPo/oHHbOaWt7G9emSoEp0xjzD6aJQPWaq+8MT/W2Cy43WnLIZbkI6LyFe+dDWttQmwWbQy1zExYutzgejZw2DNZFMMPPO2AFTu8IU1MNmpLIlglzH1diJaL7nE4jQEs9iDCr3Bsgx8yF7APq8FAy3kO7mHOn8DCaEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iH/Mg+hD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jbzyILUlZ7hG4+xGsnn51fl/LmI36mStfjSChc71Wpk=;
	t=1736240318; x=1737449918; b=iH/Mg+hDRoUX9dpToISuWS0ApekbOYSa+aYvkUYWUwN8lPk
	pdJHCUYdzBeaEhqo4M3PbR4XuJMXoshd/j33i/coGUPP4CSNq/AuGvS8CjbWjNOZXmVvzrcxe2Svp
	3vJ1rTqgBdpEx4qRi7K09tx0iHKQXRX0tJ+deJW6uUKnI5cP43jNy2tSy958XwfbuhsSf1IEyq+lx
	L3tXivqywSdmif0OP9anF1IP1B9vwDfWR/918a5KoCPH8xZ7HLko2aS7cqpQwU+FlUk9lSgfygKhR
	eYBb7M4+QlQOjMYKbxGT1XID3Kw8k4GINbBuuXuI2B1W8IhZvU+IxpcxkIqzPzXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tV5Px-0000000757F-1U7z;
	Tue, 07 Jan 2025 09:58:29 +0100
Message-ID: <5f774e0f0e00138240108bc0e4028b588e1ac927.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: rearrange kernel document for sinfo
 structure
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 07 Jan 2025 09:58:28 +0100
In-Reply-To: <20250107041727.3810446-1-quic_sarishar@quicinc.com>
References: <20250107041727.3810446-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-01-07 at 09:47 +0530, Sarika Sharma wrote:
> Currently, the sinfo kernel documentation is not aligned with the
> order of the sinfo structure elements. Therefore, rearrange the
> kernel documentation fields to align correctly with the structure.
> No functionality changes added.
>=20

Why?

johannes

