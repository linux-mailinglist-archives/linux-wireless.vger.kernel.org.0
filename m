Return-Path: <linux-wireless+bounces-18026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA6A1D966
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897CE3A4FCF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327C11339A4;
	Mon, 27 Jan 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G01oNOl1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411A8837
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991263; cv=none; b=OPVVT/3a3dCTA1VI+vfozhTmzC1DPq1iIPQx6DLfylcIR46zjmZ4QsjJvw0dwRQODvbCgYrhpPKHoW4/rySLNzcnH2heng7eRcje03ZN2veQZJgy4fpW5DW2hFLG8lOfzA/zKbrrljQ0BK4bfdQEy4CY6nHbAB/xI4wNgTKHOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991263; c=relaxed/simple;
	bh=P4YLS630pj+sIKngIzZXNX0CJaDfpIWSuim3VbvJgFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+dRbQVZqmtLkAeG35FqXHBPa/eK18RnR86ixsaHXYw8DqhxRWyC/FLy4GosWxjjVQt+61iPiTNsXfMZCfN0K4nmwV9Zp+6q++rmQ2Dhr/4dtaCENXRqscGNDsmfp8kn1ZfdGRoL0fukYNr5/Ze0r2wgFNZHTslUulxfdxfgLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G01oNOl1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7be3d681e74so409472685a.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 07:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737991260; x=1738596060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iT8ApVhyv4PImzhWoKA6aW6GniXAQEVDWB5FBbwyYQc=;
        b=G01oNOl1hH8vfH/dDz2OE28Uo2NdjB3SwIN+fhwhQPwIZ8AifnSzegGN/CB5T+zIpi
         rMXa8XAySfKN6o3ZPcNzDHoIQZl93Jd2Qnvp+WGLSXe+0G3ALdcvWgMQhGLcCdENIRB2
         4ecIYakUyB5MvKxDMw6uQDbmzwqwGcWgnB7AbtRVxpaJdxLYmHYeK5Y923mNDdra+qcH
         6FySyMEp9imbBSrZbwXLQvKSW18rgD/VNXxF2H5ptudhOTJobq/nbcYBZF6w92TnF6XH
         hnplcj+LasLyJTn3aXt4bGZi3SX8Vj4NMK72eEJPHuAXI0OUtqWHEoceEfoJnxUOKVG8
         K5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991260; x=1738596060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iT8ApVhyv4PImzhWoKA6aW6GniXAQEVDWB5FBbwyYQc=;
        b=r5FGokceQKBaDgUmh9xrWL+5uR0hVyWAbAGIerAg++Awt5/oPNsVh6Q0iqCcU3ukTK
         1iGJIYCz6UB0e75OYRgwfesKPXVPb4sqZzFCPN5RJ5w66hudbDut9QNE2Cgj+NHW+2zv
         SDImAFtMiin3i+0rVlphQvPJ5yr/ptfYqFr+1ZkGE4kqX4auPVjMmWLceYeRbpyJFcIg
         9plEIuiF5qAA4SmaKqYLZntKACXRrljgYSVdgrMNFUU40Pu1UN/d9HhNBigF4PTTx+Jc
         mkRtbBvFADBtYAVi58z/AfPZ1BBLqLI/xK08FBkgjlP2KUl0pPTuM5Hf6qu3BtegL0jX
         zxOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzWmhCbekb6nw7NsNkeUs6TRkF70hyFNlKub9wEva/RH+IGPtyEoZhCYiaefXH+nAbvuelV4pbZVQSajyaZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4sf53Y9/8nxYo6AvEqFQ7YkFfNScrSULsElz8oRm4Yu56cH9
	wgUBkmJlAHYvju8IrCzmEZs+CiIAHeLqrrYWrgJfCe4g6KgFpZMbP7Zlog==
X-Gm-Gg: ASbGncvQZgMUfo6rzAWchprnypw93jf/8CrOehydYt/D0Hv7bA2qCtKi2fv/EgdbhP+
	7elBICWN+TEFrmZAct7G/GZfkxBq9aXk7aSrtwXqQW3MlBWFO8hsAVIxtmUlxpBObfTEJlZSsM1
	PHSb9fcMT1Af2XpXG21XQhp2jd4VPL8881rFEfAVNbh+7jlr8sGgawtyYgXDJ+vsNRMIW9PxcSt
	7ytWKshyd48oS26KACb4mH4/tsb9HfJFt1KcYstXywLoXUIU8E3PAwUt74c69fP3O/CO+kAk5kZ
	Ciw/2/ap
X-Google-Smtp-Source: AGHT+IEnJnp2cYoqDLWX58VIryul0pkwYiNqA2q/DFh580edzsdHDFRBVnOr5g0yz59lplOB/9utZw==
X-Received: by 2002:a05:620a:25cd:b0:7b6:d65a:d6ea with SMTP id af79cd13be357-7be63279052mr6779176285a.46.1737991260487;
        Mon, 27 Jan 2025 07:21:00 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae7ec43sm398710085a.24.2025.01.27.07.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 07:20:59 -0800 (PST)
Message-ID: <375f302d-7597-4880-96c7-e301e8c7cb4d@gmail.com>
Date: Mon, 27 Jan 2025 07:20:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: KeithG <ys3al35l@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>, connman@lists.linux.dev,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 iwd@lists.linux.dev
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
 <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
 <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
 <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
 <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com>
 <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com>
 <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 1/27/25 7:09 AM, KeithG wrote:
> I just tried this and it connected 2x once from a saved key and a
> second time from a new key.
> Will continue testing and let you know, but this may be it!
> Thanks so much for all the support.

Thanks for the feedback. If you continue to see issues with this 
configuration let us know. I'm probably going to just disable PMKSA on 
brcmfmac for the time being.

Thanks,

James


