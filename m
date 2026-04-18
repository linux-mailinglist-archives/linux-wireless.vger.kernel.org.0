Return-Path: <linux-wireless+bounces-34965-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eguAGR2L42lbIQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34965-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 15:46:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 941E44213F3
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB24F3010DA9
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781C2248B3;
	Sat, 18 Apr 2026 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWJ9aLRn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96313777E
	for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776519949; cv=pass; b=Q/joEvFBafWMFepH5fphcEdJ89VTybvXotk3oYJr6MKQYxgSByIK7SczWGhlooHNr7h2tfcgK4YXJ0zjIZ7RFi7inkOyKx52z2VyurbmOtlibRk5aGAUpXuMrQ9O08l95jWxEx2cY/Gs2/sHhWl20niak4Xh75nkVCU62OS/w4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776519949; c=relaxed/simple;
	bh=eReUqEIV5G29hsIzDdEl/amEYUWPsTxKRlJTE8aNN+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=du8u7f3GIMeJO2ufc7x50taEA3eZbDZiH8Pq658sljpg96YtVzXPyilD/OQtkbQNdmKxOIi/jP5KdS6PIaLGbLqxQjU3L7QwIxGb7DiL6nWZHChSQA6pW7lsI8OJb+Gi9w7AZn2KXmDXdBhxqJkE7TfZsxzmpD6B4x8pQ/WssTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWJ9aLRn; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b458ca2296so11577745ad.0
        for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 06:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776519947; cv=none;
        d=google.com; s=arc-20240605;
        b=Cyv2jF6PAbIRvUD4JZOX2sZBYszvcLSlFqddECOzXGImcwOdmUB90Oq4FCQ5FlzRAT
         1NpvQ904VI4DngZRQB/tL/f2oDqGcviDNvJgZ/G7yHx5DPviYNO7gXsb5NL5EDUZr1bM
         jvuIGGNMX8rC4P5XgXNzOpnf4fv1Gbj48xOlp0f4SRBr6EdvgVl48DcQahFrZY5JJtY8
         novAmqd2UBbty3SUBze6n9SVIiWW5FWiL8GhCYKmx/6NsFyg1KUwFPXZX1Jq682NLGyR
         MrexVQ7TfEe++XteQKMZ0LeVm7sJc81p8jMpqtaar+jGGav5H+Rn4g69EvZ6NWV7m53o
         PAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=UaCcW5VnF4VqyL8Xs+sjoT0qxtA1NuiInpI94KeWquQ=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=EPoUVlTW4eHAOuNqVDAoH+uQ8q57LLHR0r3y7ofkpMQ9ATLBg5KBYSLTOb5I5rWClu
         qyvfe9PBCoUP8HO3Ly+PUIOB0S4foNdDHH/wSdHfmkhoZJzQoyWoldzcasmqm2kEx5OC
         W49aKlXvzHVaSva13I/laZlU/gGpq28rkVDbYsI9EPFV2f2U1gnGXcix06UACBpQSM27
         pnxCH0H8Wt2ceKEJvudphsXJk8DCELf8gX5S6zn+DvBCjAwC79NhxO76boY/TQJ71ZFi
         /HMVc9O053t4S0+EtdcweMJaX2ESjBlHzGnrGXE1M98FHZeOkRLJ6+QIFwg/dDFrmo8M
         ftUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776519947; x=1777124747; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UaCcW5VnF4VqyL8Xs+sjoT0qxtA1NuiInpI94KeWquQ=;
        b=VWJ9aLRnPKbl3+kdL6nepzMRw2DedT2JDvipHUM2jcfWPnLjqMa+XYoXDo8dN+3yqp
         w+oZzJsbiyHBDrIghrfA1y5yxZ6Mf/hgLPqbNSm5C2NBdStYY7ZBzotfAeQ51QN/KvAl
         fAxuJgJCXk4+3Ngl5wpQ5ukJ8VepuNGdXmNB0WBjL9XR+fkKOrY4YetgEad2sq4FFAqs
         BxDx4dow8Phc6lEdHW6QwFkexm7WTOnRr48EFHhBR87CXO/qG2xM1OmEFW859NM3mR71
         aZR8uQY0UA02AckSAO19Fak1RhJSh4foHY9vQIguUTdA0q9npesIk+RB3T4XuGQmUboN
         4fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776519947; x=1777124747;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaCcW5VnF4VqyL8Xs+sjoT0qxtA1NuiInpI94KeWquQ=;
        b=bgk1noH/sNTdkVnt3QUoIWSsiWhzaztp1/jywjBQEdeDNISKjRaVlX9o8aklkPcEV3
         2GgoizARM/11zmXVH4ZLU26okZsIc3hSiFBFcdv1LJ0SfEV/H3i6iosQBjHapOiHcsLQ
         oviBotCeUNR6QxH8xohRc47Ihq64ykqwryrl3h9YaCVWflfYWEkwx6d1tFok62sqrU3J
         24rDghOwOnWQ1WRAVO4aheN3SJteFRvmIDUkxYNGNVIq5P71mytfJTrbNSF1W76LqESP
         MFSIiyuYk574Awc/YbY8WfyiSF7yY1O86TFXMZOK59++hVtiQhxQAPZIsUM+oPB1NsXG
         kl9Q==
X-Gm-Message-State: AOJu0YxkdgJ1BTpBczfpVSGbAS4XXr5zlXmfEoxNhBWM8iBEkDVAA5G9
	phinhC0Rb6xOIGdm4ThgUqmgEV2WNQLGKtg6LR99g8O24/RY69kdsNB2X8+Fw6Vag8NARzoh0tg
	rW6bEFh/c7MCbNQ1KbrLfVR6E50hxJJGWvbwH
X-Gm-Gg: AeBDievH81OL5f7MSGPLPRaaTZCVPTvKQaJDHtQvl8OogdulgcI5wEl3wyMHz/RaIjN
	m62qzaBkXmeW7lP1NapblPkTMmsoVwiJkWA1stv6xdfWTccwuyxoXW2IWTkuEuKFFN39jyzlUg4
	m2odwO2I/oOG2aLO6fhlprPx+M/JNXmy4SHln4XAYD7whBbS81vvOvsCyBzxm06SyA13lXTj9pZ
	6c1kaXdlAnb952+pnkv56YWyRY0j+U/ITVctdNtTy1/W6eK/llXhKuWJHhKDq2uTVPqIuKdE0Uy
	R4EvEj0cNo6a74A4i1mdaQp/b3Z3DI4x
X-Received: by 2002:a17:902:ce0a:b0:2b0:af2f:b27a with SMTP id
 d9443c01a7336-2b5f9ec3590mr68139245ad.11.1776519946950; Sat, 18 Apr 2026
 06:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
 <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be> <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
 <beee4be9-2bfc-4c38-ad1b-13ecc7d90aa3@eskapa.be> <CACM6vn7Dau9cX4tUCVQZmEpRmd7JiNtALUfR_fFARMbR_VZ_7A@mail.gmail.com>
 <5b3d8cb4-13a4-45ca-8ddc-0692ace0488b@eskapa.be> <CACM6vn5FpHycsv6=bUwP2yBmV_an69zTgsJKJPVdewz4cnv5sA@mail.gmail.com>
 <CACM6vn6ySMs0HUFt3ddFc42FTakJ_dnWsBOfiiN+6ORZn9cm7Q@mail.gmail.com>
In-Reply-To: <CACM6vn6ySMs0HUFt3ddFc42FTakJ_dnWsBOfiiN+6ORZn9cm7Q@mail.gmail.com>
From: Benson Bear <benson.bear@gmail.com>
Date: Sat, 18 Apr 2026 09:45:35 -0400
X-Gm-Features: AQROBzCqpEK7NsYL_LTak3gcgTIHcjInHPikEPJ5fyMXPKXk3ClmLd4b8_I1j_0
Message-ID: <CACM6vn5hAWv1rRNNByS=5RzAcxhC5R8BpvjdaDVb7iG+o6W5+A@mail.gmail.com>
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-34965-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bensonbear@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 941E44213F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kept working at it but where I am stuck now is that without M2
in the handshake, wireshark cannot decode the M3 to see if
the IGTK is in there.    But before I try to somehow
force M2 into the capture, I wonder if it is
better to first look at wpa_supplicant somehow to see if
it noticed anything funny about the IGTK.   As Pablo said,
M4 itself is not going to be recording any complaints but perhaps
I can find that wpa_supplicant can at least speak up locally
about it.

On the other hand, as Johannes noted, even if the PMF
was set up okay, it could be any number of things
subsequently that mess it up.

