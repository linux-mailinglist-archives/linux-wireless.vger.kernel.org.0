Return-Path: <linux-wireless+bounces-36771-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KbyIx2OD2pdNQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36771-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:58:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B55AC800
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 00:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 669FD300A3A3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D388305E3B;
	Thu, 21 May 2026 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9OENXlR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29F228CB0
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404314; cv=pass; b=WsGP9P9JPZFHXCDe2VsuRkdCwBHXhoinJXociQx1k0Q5u7y3Q9v78O9O20BNneSNg939bIpaNpxgxlmfTPgoqPpxbySPO45tk3LP+NM7U4Ly/OWZO9qlpViBSvSnaACa6fXpOwKSwxVT2XjHq41hureGHhTsUVZt4YlBHet940Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404314; c=relaxed/simple;
	bh=Us3rQJY+xJhjUTDQUH66uDlps8mpx4jHIrgEdBsstcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DD3PQ/iyPDDVtK6bLv0ealjNoYIiWMcKSeYdlIvVyGWZPvhFzHVB0zz9BuYWGOXRVCEjmKw3EZQGLdlY55wOMKNtOQCKSkiPGxNTWjaUC8Z4wmyP57aZXoPk0pMZ6+BphAMAqAnxtULMGxHkXqhRLz7azVmUuCHi8bLYIh4EX8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9OENXlR; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d73422431so4684060f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 15:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779404312; cv=none;
        d=google.com; s=arc-20240605;
        b=hwnkcRJLwoMJAjKUHW/zqKF7Jr6tceKUGU/vU+JRsGpJF5i0wszMJ9V5Y8SkyDUnkd
         5PgTZElt4yX2HleEpEtea4C0Q0obBV8CW65nvBJUclGL7rDXkoC8R3XN+TU38MOlh48A
         iRI5HzjA3XvFYw0LtRRJY07jTMjNuUmue1mLEB8aLrUfpmtJDk+PR2XcE6N6JNVO02qu
         T97+PefbNOq0J1yieCGenIX/ef3UvdjZN+Aks4CHKdeTrS53SD5OZEUcZ+Jqz8d2mQuc
         ayomtXDXLyUAEYTXtrQoUkVZYE7s5oZNIEtWOUY5CmVfk6plwtJXWW1Losqdlvq+F8ZI
         Gb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Us3rQJY+xJhjUTDQUH66uDlps8mpx4jHIrgEdBsstcI=;
        fh=4FQqWgVsOsYy3/4k7Vy5fkONknS6QGUaSFpsbG052gk=;
        b=fpEWZt57fS8+hlErfkOf6QY2HSNggbnhvWGhQ1HV+0JxqXUjEb9BfEaDkQuh50b97f
         hDQVtaQLOs/++BDVV5HlbvkUl8e70yu2ifOhPlKtp9cI+QxRBWjJ/MdAMsO1URgX3MUD
         gIefdIpkU/HjvDhISj9rb4rb/VpuN4ZMmhY8awmtFLBx3aNbFJHMRN4eiwe2+5F/ReHd
         aO0Sf2a9taULghAriortqwsqGMIthOJFkWoPXIuBJZpsVM2KYbbgsbvs4SOAk/a1ig1c
         QD2wXZcZ8J6sTqC7mwptjxfHH0TnEiMsYBDNv0y780pP4ILDtVNtdeLRo3mYSa0mcmt6
         2Cmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779404312; x=1780009112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us3rQJY+xJhjUTDQUH66uDlps8mpx4jHIrgEdBsstcI=;
        b=X9OENXlRK8WhXDL2j7K5xZ3Zy60Gxxb9b1QcFi0jO9LR8M4kWfA96jZr0xSYxgyLUr
         gzNR8MhCaskczx9IEHJTTIiNJky8tI0LGhj84Ojm9Jvc3FwzNZS9/WQOaLMwScH0rINN
         t7S0qqWtCXdzVpnzZM2u4sLmC518QoeZViRA8VOr0uFYQH0FavufoBeDnJ2DSA6tdN7I
         oa4jTdBNHRu0zyFulVE/TDuziYMdhemWhktMs6oUelE82erkXC7aTu4auipbFi5GUyhT
         wck/3Y4YmqO69S1AL3doYZJRq9dY0AlzpI2QpdtjaF/EegU0InsBmCmT9gisZmyT350c
         CRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404312; x=1780009112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Us3rQJY+xJhjUTDQUH66uDlps8mpx4jHIrgEdBsstcI=;
        b=k+fyFLT0Bu3jYQcX0Kuu7KWC2JslwOXCas96RAvTN4JKx5nMgIVcqeWr49dkc/gWUF
         LwMydcG5w7chV1PEmo/zzOkEByqviqhWazwgMfQU4eMoRnHQ1i2Rg0+lNMpA+SZMO+l3
         xSnQ8UiPnhPTjE1ZKHRAZ40uo91kOqR+V+2aZEmBJ9OLrMNo2QF5Yu1ips8Pro+xuIdE
         b0MSMH0kqno1PNfZ5RNXRTJVRocXQP/O8lVvfY3T+bUW0U3NN6k7Rb7NZx1/LZ2Qfr0k
         WPnEqGsnpHI/SXswjTRaVYDvKPXiU2C5O0s3sEn67clZ6V7fRf50eaZaI+M5SHANsEGB
         35Pw==
X-Gm-Message-State: AOJu0YygXWQde7/pBkDZPKndndHQ/6SA7G+QTFXfNHz7JXLCnR8SfN+h
	H5nYB8l1O2y16U2a8oC01D6RRxooHK+xFEkMjAw6rrGoac2GD4BsnEMjNHL+accmIQW7aTwY0Ja
	4attEZKxKOzThKXJ7Z2FIBOFSRLubFmDCVg==
X-Gm-Gg: Acq92OFiJ5ZttQEdbg6gvKTElEeC/va3fO0KCSO6RWxQ60kGL5fKvc7tYYK3JNAAq2U
	ezL9Vc1EhwMprNfRGBufgbJReU2j63xTT1FMYwkn0mpvpucy9FwI0qt2QKmHvrlo+he24+Pojbk
	Bdz3MVbqomAJPPoPJy/svVGeDBZ+aglocVYmxIjmzpH542MaHeOBjC3FG0QE7x3/PDd2UOaMq4+
	2AuMPI6bv9MXr0KAoNvO/LhciDGrwCEFPJtiSLL+4YPQTLQqYekpR7ssPMLhktrWSvV1KhEeOdi
	W3Gte3Azyuz+YA==
X-Received: by 2002:a05:6000:4707:b0:45e:75c5:1a6a with SMTP id
 ffacd0b85a97d-45eb38bcb3fmr927509f8f.33.1779404311753; Thu, 21 May 2026
 15:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521085647.394151-1-masashi.honma@gmail.com> <87dfbe33-7705-4ee7-bdde-565d2dfc8287@oss.qualcomm.com>
In-Reply-To: <87dfbe33-7705-4ee7-bdde-565d2dfc8287@oss.qualcomm.com>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Fri, 22 May 2026 07:58:19 +0900
X-Gm-Features: AVHnY4JG06O8gGDWwiWeyy-vWvqZjTYks2i-nGyy3XQ9Y9TWkZ1Zu6sokbwwGmc
Message-ID: <CAFk-A4mF+cWTougEUAzMQ2KRFuA6Juhg27YPMm3xMRjsRudY0w@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36771-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E74B55AC800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you, I fixed the issue.

2026=E5=B9=B45=E6=9C=8822=E6=97=A5(=E9=87=91) 1:49 Jeff Johnson <jeff.johns=
on@oss.qualcomm.com>:
>
> On 5/21/2026 1:56 AM, Masashi Honma wrote:
> > In preparation for subsequent patches.
> >
> > Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
>
> I'm surprised Johannes hasn't pushed back on your sparse commit text.
>
> We have guidelines that you aren't following:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de=
scribe-your-changes
>
> Having commit text that fully describes what you are doing and why you ar=
e
> doing it makes it much easier for folks to understand and review your pat=
ches.
>
> /jeff

