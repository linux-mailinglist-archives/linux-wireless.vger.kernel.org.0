Return-Path: <linux-wireless+bounces-235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927C87FEA6A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C94628227E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793FC2208F;
	Thu, 30 Nov 2023 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCXXc4U4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF68B1708;
	Thu, 30 Nov 2023 00:24:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b4e35ecf1so5369395e9.1;
        Thu, 30 Nov 2023 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701332667; x=1701937467; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TQqYuMpS0IutFQA0jTxrDWzedXIaMHOHDdeUN7WQuw=;
        b=HCXXc4U4qeU5NoMLfrkZLt1igmtQJGFlm7+aosTsiMp7Yj9VOosR/urhQ4VzoIisP5
         jyilxQ1GMBUGx7VXc53QcSgQy2Fo639vDS0rB2U7vR/vLRncRAfQsBnA9hUMbnEeNQ8G
         RTVAPkVRYVgGKi5uoXdVVS+k1L3jCEBxkUQBREbLDNzmpfEa6U7nIoF7fF1mvrMkWl2b
         RZ6oP2KX956eym6uYlYeDUOEtAIgt+bPc3uDnWGPaeysAEgj+X5D9NBbsg+GBOpHE+Xx
         cH2rCxdpATqQ7PaZuHRo44PnJ9CEw64WFyGJMyGtzINuTt/b0l2NDiTYr2IVUQsKIvm+
         sEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701332667; x=1701937467;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3TQqYuMpS0IutFQA0jTxrDWzedXIaMHOHDdeUN7WQuw=;
        b=ikKa+nZ8xhFfB/IURMRape1sSRUUJWNK5DUI3kibSVNPZ1tx9hbox9S+x1xwN/c7en
         66SbKgRHhCtqJQJeZWydDD5ZwfjgVYJlaMOG/wTV7jqA/2Q1DaWR8hEs3cb0GNZFstJG
         eQOK+XyhLr6/5lZH0gkC8GeDB3qO/JxpOgYFhgUhKT51B2knY1c19pJvFYtyH79rirhh
         eZq8990YNwgskCexIX/Ap9SI1KIQnQktPNTHvXQNBYgRRs4D3HZPCiBLwGo9LgQnD5la
         nh6JyjmAdKAPucMNjoYw0Bxyz7zRir9LXwA1B9sd9wUv/sE2bM3z5cLLG8ZFGoJpFLoh
         Etdg==
X-Gm-Message-State: AOJu0Yz5TbmtRJi2lkelob5nJeFs9YLNpFW85sUDtCYPLKifsdnYc5ZC
	b7mbuY3dHv/24D/1YiZzN1I=
X-Google-Smtp-Source: AGHT+IHWJgbhZy4z5ajH3SCgvaHk+CQS1O+0oW2p34le3I8bCk5zc+Q4Ge9qW03jVvhxInLNxkWE2A==
X-Received: by 2002:a05:600c:3b20:b0:40b:3e23:f0a0 with SMTP id m32-20020a05600c3b2000b0040b3e23f0a0mr11358637wms.4.1701332667016;
        Thu, 30 Nov 2023 00:24:27 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c1d9700b0040b3645a7c2sm4839247wms.40.2023.11.30.00.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 00:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Nov 2023 09:24:26 +0100
Message-Id: <CXC03GYAN4VN.2PQ88Q1S7IL6H@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: fix layout of scan_flags in struct
 scan_req_params
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>, "Kalle Valo"
 <kvalo@kernel.org>
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ath11k@lists.infradead.org>
X-Mailer: aerc 0.15.2
References: <20231127180559.1696041-1-nico.escande@gmail.com>
 <bdcdbd06-e9bd-4a92-b27b-d94b2d8fb52d@quicinc.com>
 <CX9YPUDTAT1N.23DMRB5O9FEAO@gmail.com>
 <20c7a367-2243-4e13-b023-9999dc6c6790@quicinc.com>
In-Reply-To: <20c7a367-2243-4e13-b023-9999dc6c6790@quicinc.com>

On Tue Nov 28, 2023 at 1:57 AM CET, Jeff Johnson wrote:
> On 11/27/2023 2:54 PM, Nicolas Escande wrote:
[...]
> > So either we should not use WMI_SCAN_XXX with scan_req_params.scan_flag=
s ever
> > and only use the bitfield to set scan parameters or if we use WMI_SCAN_=
XXX with
> > scan_req_params.scan_flags they need to match the corresponding bitfiel=
d.
>
> IMO the correct thing to do is to remove the unions from that struct and
> only leave behind the bitfields and not use the WMI_SCAN_XXX masks
> except when filling the firmware structure.
>
> But don't spin an update to your patches until Kalle has a chance to
> give his opinion. I'm new to maintaining these drivers and Kalle may
> have a different opinion on this.
>
> /jeff

No problem, I'll wait for Kalle's input on this before doing anything.
As soon as we decide which way is the right way, I'll work on this. I only =
care
that this gets resolved.

