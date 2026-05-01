Return-Path: <linux-wireless+bounces-35740-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Eaw0K20y9GkH/QEAu9opvQ
	(envelope-from <linux-wireless+bounces-35740-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 06:56:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BCA4AA6BC
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 06:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13DDF3013B65
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 04:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAFE29A9E9;
	Fri,  1 May 2026 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfGPCxy/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546EA20E030
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777611369; cv=pass; b=ixbPH9aWQKPFAL2+BuCJ+M4geXag4pbqzXDg2T6iRsPRa1w9UMNKMKhpzOOrGMPYzcxzQdABYT9++Xy0KbxbnsLB/WR6R9HCSE20AjtTqyrb1IV4fl3+Ll3YWFxLjMLaQHkKSckiWNMlyTtaS1J8hgS6nbzo07AuklgcTYOTksA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777611369; c=relaxed/simple;
	bh=x+phgzv6lPWIGvfVvaWgSjPsQMmh9IBJTE9oUfRI7Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4byLfRkqS/h/4B+LK7Hfc5JBRlQaEGVkZxLL09Rgzlg5GEBSbYuMJfiNVaMPJ3MQgl3JJfYJTec/jVHn0yErHWsA8grAruA66XYUOrabJEd7GBFDxzcFcZWD+D86JQvQAEQkoHd1K+rRUxBs08uesnIGCl7yZXDkWLa9wmyguI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfGPCxy/; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dea20cf21aso1629708a34.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777611367; cv=none;
        d=google.com; s=arc-20240605;
        b=cw8HGBO1owxiprqP7bt7kipqVHahpLlrhquo4OR1kNrUsd/roKt/4Iryjn2Ns/q2XV
         anMNUZv1Bw7nftS9Dr/k2JDRbQScRr3tbE3i6XfBqS5r/5cKzbBLEE7KG0UJ54iJi0Ew
         ynWBv4Vb7TYVVMvQ2sRh6HeIwqJVsDmdEaQ6K/jNwywTtlx27hos5+BNvDCq+AV4a1Mt
         w5vb+fg+wG2Yke+8hot7XKJb3oojgXr1kLw6ngene5ZgNGdPS3YE5i0fLmrPy1Qy5s76
         EsB0tvN4ESj3uRXsPExUtzARVvxt41XXNexUVYdH65P77NXUnDi4cG4llN5pfVNoVrbe
         h7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x+phgzv6lPWIGvfVvaWgSjPsQMmh9IBJTE9oUfRI7Xk=;
        fh=zFCB9yj6tbPtiNOgT9n/qK9LnQKfgtX1AWhCxXtoerY=;
        b=NFjV/wGC08WnvW1vRXRHM3v+FsKki90a/8xS3uO9dJjmwlWUp2AADXs0cSaSgbC6Ov
         QyuR+IiZ0urWPZ5WUp2lryUPtlkWwBA1qf3vIPhAO4j6VLhstwmwbu7fGsqWiZaJOQVP
         aaw1shaYcVfeXsukOJS/0P+D6DoVYnmTC4pe0wLBlPlcmGSQHUeWyyp+xL6tSYP6jsrq
         Y4EVdvvDqpG797xXqsjtsQrQcmZRW/NitxrTKJxCUJA+IGO2UVgICB1NJONJRKcLxPyR
         DPgt1ulPWQECy0C4pCVLSPqW6WiRRcYLz2bP/IRnCCiuJL5JcrAJq9GOGJNg91c3B0IT
         BX6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777611367; x=1778216167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+phgzv6lPWIGvfVvaWgSjPsQMmh9IBJTE9oUfRI7Xk=;
        b=bfGPCxy/aQTJiuX46Ex6Yl1zHv72KNEZeltOrzD7DCb1l0dZXkgHDDM8jXpEMnty/8
         Mx7u+it6JwwiMFjDLPAq/UM3h0eMQjP47bgyjGs0rLX8HaghXV9r6lZqdSOxqW+i/0vK
         I3FABJMLCrygDRXkeTooiU/dzL29zSm7O/LEPNUo4Ir9e2NceGFaZlwKgNkEefMOFIjP
         akrkMET+qZcCaKioKI//hU21VWDAY0BPAD+/J96N0mNycZnscLOkXjlu6cGpguwE5N5N
         h1g8KwyCPtsi3EHH0qt2RvAAPZZy3f4wI8Y2O0x5shRQSHW0H7MqWYiLnYOD/kxhUzH3
         hozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777611367; x=1778216167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+phgzv6lPWIGvfVvaWgSjPsQMmh9IBJTE9oUfRI7Xk=;
        b=lvjU7CZvFvqefDeV0/IKbnlsHvrf2YJN2mvJ/TEyiGNDyQAwhjaNh7fUlOVm0fLvef
         nEeiTmtT9ZTXj4AJU7JxXPGf5RVmO8exMDRdtjsBc2nHTzNoNVn3IzzI+nupEne5dOP9
         MsGfvUIlEE39slHbvuuCpDdP/cIZLZMQoqTrxtB6wxQTJygghWQeBuUs/FBhpfrvNweY
         g8agZo/J1XoEi6E+W/ZhELz7cEX8nNqOGqAOHCRmMyjfIr/dRNO1OkCdan5XLmwEK5tY
         C2n7UPit/F9ayG9g1Igmblfdzq/miP7UWPDlHpvmCI7a0jSGG7/DII1W6L3gktFtEUOK
         vR9Q==
X-Gm-Message-State: AOJu0YwOl854u3xnL/34u/Ppw4K16yy7vuRug2itrBapke3wCLEZXKcH
	dGyNGMcVaqhZiKpbK74u+vqvfSbN7CzJx5weoUVRZLRmNKKOE2vbphinsClbNgajVi8EnDZL5MJ
	v+6+pPt/tmKt/B71EFHDEAQgzDm9dFb0N9g==
X-Gm-Gg: AeBDietBp0zKRfpJgpPyigzbuKrvzv9sMrIKb2pvyZoD2vYr2VWw7IHUXYxcmdunJ0h
	mh1sojNJO1x2BrIBH/n5BUjyyAUrilsOUrcC1X6VvqgQg86NwNOgt4ouAoYGwJRp7rZM2tKUCWH
	iTGQdaRkjos5Ipl3Os73tv3CUavF7K4vqyE8O72KhjqHoV2Pp7iZgOaBVt1H7LEEdyTb8SZXIdl
	WuEe3uKqtdZNCdCvk99XDBRoXsZ1ZrgQJlpaQTpdUhQXYNdQIPxGwWB8jgSWiEMhjyXR0vG9cQT
	d68jm0WCfgLwX3oCjaGXkcv9146PtI4FIDcMdtsJqyFszLpNeAGf2dR5JyXO
X-Received: by 2002:a05:6830:81f4:b0:7dc:da80:42c5 with SMTP id
 46e09a7af769-7deba3723eemr3582303a34.28.1777611367166; Thu, 30 Apr 2026
 21:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEAGRPaA+Cw3wykVXpFHfs=qwQCv-=VuBpxisg6VjOPGaGfXDw@mail.gmail.com>
 <3b9fedf23b39409f8b5979ed36ea02ed@realtek.com>
In-Reply-To: <3b9fedf23b39409f8b5979ed36ea02ed@realtek.com>
From: Sivanantham Chinnaiyan <sivananth321@gmail.com>
Date: Fri, 1 May 2026 10:25:55 +0530
X-Gm-Features: AVHnY4LIFZ5Ujr9vN4lRsW4KgIMcnpfKMGHYCY7CU1NMsL0nh8yB1QBqpzKnNtE
Message-ID: <CAEAGRPbhbhfAYhPVec4j+VWo7yLUhiaJLSF7NhJrTsVH0D5X2w@mail.gmail.com>
Subject: Re: RTL8922AE: Severe latency spikes (>200ms) during wifi scan triggers
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 26BCA4AA6BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35740-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sivananth321@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

> It seems like the ping latency without scanning is about 50ms in your
> environment, and currently off-channel time of RTL8922AE is 100ms, so
> roughly it'd be 150ms with scanning.

Got it. Thanks for the clarification.

> What is the problem you are encountering because of long latency?

I encountered disconnects / lags during video calls with the previous
kernel versions. But it seems to be stable from the kernel version
6.19.13 which is what I am currently using. So I wanted to check with
you if this can be reduced.

