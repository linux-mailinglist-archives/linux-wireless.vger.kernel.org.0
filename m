Return-Path: <linux-wireless+bounces-17113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3993A02EAA
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 18:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187C91880558
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0665C1DC9B2;
	Mon,  6 Jan 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPbeEh3Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960819CC2A
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183633; cv=none; b=p82NpY98JvFKRvc1XQ/RAaUHHMT8CIpJ6vbQQuQf8qZQ2vjwQWB5E6PSKasIHbGWVhzdEXBSakukCgqiZDJDDFR0v87DWYU+pwzCwj0m8aHzBX0tKSg1VhSEqCPMwMcqAvJfZk2YC6mXYC2sgm8tG8en4MuYvrnbNHLj9TIZh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183633; c=relaxed/simple;
	bh=4X6zyYxK1QCiG9SsBLkpMIskQ4/0BPLxlhV1jv2pTrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcNNB6buPXLI74Ghvr4btmZlS40kpMOV9d7hezqIuPy0igNOO5lOBTFMjcSHU4OBETxY8fwcqWI0XWGbtRhloX9Ld74RWSbONg8QbNTnvPV9DV96zUwXFrL0/uyuv/5WD4PU71vzY6ilNB17Iup3uxZNNh/bXkjmja5roJo2n0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPbeEh3Q; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso21201919a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2025 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736183630; x=1736788430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E4VBveUTiXAQY0x0OPSL/+vTNEOjG/u16OolfG/dLM=;
        b=JPbeEh3QDAXG8WsLbQKWt3AZ+GwjPebWfHVJL3EbdTbx4FaUvXsrzsqASx3npkdlCa
         aEj7292Gf9otXQV/bUtCYR5ZfE9zVB1wUY1CasrRL7wDjgAlCcoLsg2LJRTBGqtSGNSy
         CInyODLoN89yKMSn6sLqHts4Q6PrRGv5YPW+/m/jStmsd2MUwfFof/834ly5l9ilQv3e
         PNWshJbITqhhkhXZ5JlbbT5dFZHocQfrcCSU3iuT6mOmXuJ0Tsy4QPJsh2ShtpYRqm4l
         uFt3NjKlkrf6qB3u1Lbyy2asgQmbk0tJ/NI3hDteB7khugRdzW+JqBtr1bUOBG4ZttI6
         Hn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736183630; x=1736788430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1E4VBveUTiXAQY0x0OPSL/+vTNEOjG/u16OolfG/dLM=;
        b=PyRC8155b8Fz0Yyf5Tsy+DK3m8FMruqZR2pCUSpE1COn/HsAcywbEga3v9AZXqdesK
         fylnXhOzw/2yaxthFzpVpvaMnMxpjx4du6L6FCOG4yvQZxT/VP2DK0AMLn8V3nAGxk6f
         c9Zoa5LR178obmi0ihbCNLP2SLrhgQbmQ/9YDSxpDOiyGuzlvDPXitEHab7JMsGyY90R
         tShvd1z1f8DwvnPXdwVBuVlTlpccYlA4DmZtOjm2tt5OnzR8YwjptGV5ZX2fb/4rMZQ+
         fS4+nkJwdIWCrtcFyOmgwfaFWcJSxrMEDP2wB74Hd6FujYLD3vEJ9PLtWNljBb6MpKA/
         hRUA==
X-Forwarded-Encrypted: i=1; AJvYcCVeJ+RpxKNYbTZWBX0jqOylCR+FSt3iaQis/vE3pGCXcxVw/kAynAHIonkvVcsIogftGON5UidFJeUqJHB6lA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy756j4zeY0bMiyhCVYhSMgwukW9BA8SCrrLyxscpYcDIeYovHb
	XSRsHn5i5xviqjANam/6ZddGQbDOSylkzWdBfUCN/I5wRSRu5gmZLgdQLEmD08+vh/AFFD/Wb/h
	fCrTY15oe7s7I4L3XQ7gh8AX3PTs=
X-Gm-Gg: ASbGncu636C0SKC6EkV8itBsHidFaNa/F29Didxka/QOsZbew35UE9iBVoYb6UeTN+C
	5aDpaR+XWPsWIx8K2aHwU46/KWOQ+akveZIUyF+gv
X-Google-Smtp-Source: AGHT+IGFEmKlsE7w4ki0FRERAZd7MgyKM/i6eTRH2L7lzZ9eaCyLEYA1hsVHBLYEJEXYfzPLxFzRrjHg8V+00MjhZ6c=
X-Received: by 2002:a17:90b:2543:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2f452e372edmr79317340a91.21.1736183630396; Mon, 06 Jan 2025
 09:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
 <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com> <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
 <c586f9fe-e1f8-44dd-a867-ec21c78c7de9@gmail.com> <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com> <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
In-Reply-To: <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 6 Jan 2025 11:13:39 -0600
Message-ID: <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: Denis Kenzior <denkenz@gmail.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>, James Prestwood <prestwoj@gmail.com>, 
	connman@lists.linux.dev, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:26=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> wr=
ote:
>
> Hi Keith,
>
> On 1/5/25 6:41 PM, KeithG wrote:
> > I am looking at the iwmon logs for a successful wpa_supplicant
> > connection versus one from IWD. Both connect and both pass data and
> > both grab a DHCP address. I do note one difference in the connection,
> > though.
> >
> > Request : Connect
> > through the responses RTNL
> > wpa_supplicant knows it is dynamic
>
> wpa_supplicant doesn't manage network interfaces.  I assume you're using =
ConnMan
> for this? If so, ConnMan sets the IFF_DYNAMIC flag.  See
> https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/inet.=
c#n372
>
> >
> > Whereas the iwd log does not:
>
> iwd doesn't use IFF_DYNAMIC in its DHCP implementation at the moment.
>
> According to 'man netdevice':
>
>                IFF_DYNAMIC       The addresses are lost when the interfac=
e
>                                  goes down.
>
> I doubt this is the cause of your DHCP / connection problems.
>
> Regards,
> -Denis

Denis,

I am using connman to manage the connections. The connman config is
the same. The one iwmon snippet was with iwd masked and stopped but
wpa_supplicant installed and the connect performed in connmanctl. The
other is with wpa_supplicant removed and purged and iwd started,
running then restarted connman then initiated a connect form
connmanctl.

I pored over these logs yesterday and saw a few differences, but this
was one that stood out. I can look closer again tonight and see if I
notice anything else that I can summarize.

Keith

