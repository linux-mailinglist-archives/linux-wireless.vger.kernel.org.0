Return-Path: <linux-wireless+bounces-1472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4022823BFA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 06:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EDB2854E1
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 05:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BFA1D68D;
	Thu,  4 Jan 2024 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIMbWGnU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBFC1D54A
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 05:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150A7C433C7
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 05:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704347927;
	bh=hlQErY/LfTDpjZ1rUHb5dP0eaPdYFN45VDGUv9NcCv0=;
	h=Reply-To:From:Date:Subject:To:Cc:From;
	b=nIMbWGnU7WAfrTe9hFN6fevn6p3PcvWK6qKRE/+lDY6ZF5A3SCI3hjQTYsNgcU4DV
	 A37+1z58TkYVmOKIJNMouJInDOzRGkaz6TG7F9NU59OH1VnMqrB8GXuTqQ7Fe9ltuN
	 rsi5EL1y0uEnMY/IbXprom9ul0mXuP6OQEOCplpb6RKUYo6beWF26Cz8/3HdJyJvVh
	 XRcn0iVkSmOnV9+MlmOljvHJ/yGaj9wJ6zlSeaoU7AZKRW/EmV4SBc3EGgu7BHrmlM
	 QlST8P3D0rifcQgkshcx8z/0xuqT0QdCinpQ/qX7PVS5BAAYozSpK1ZtXFcI+UKTTY
	 i8V7XCn7ZTZ5w==
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so140180a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jan 2024 21:58:47 -0800 (PST)
X-Gm-Message-State: AOJu0YxV1bNQ4+v95yogVMCWveDD99c+AnkUVfbCmlEnXWsv6jk+UAf4
	WHCajXkg23vANIARpmAdopDQadwhEqKngx5ZPHU=
X-Google-Smtp-Source: AGHT+IFWvtkrJvY2JOQLCUBR8zfgKjydkC0Z8Da7jVJa4ax3WJiILtwdGcJ4nODELv8tSY4dfcTWYaJIk1P++jXLCLU=
X-Received: by 2002:a05:6a20:6a1e:b0:196:163d:364e with SMTP id
 p30-20020a056a206a1e00b00196163d364emr80715pzk.55.1704347926672; Wed, 03 Jan
 2024 21:58:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 4 Jan 2024 13:58:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v66xVLqr+tUSD_6uzguGXtj04WfbpT0z9M28r8z-g62Z=A@mail.gmail.com>
Message-ID: <CAGb2v66xVLqr+tUSD_6uzguGXtj04WfbpT0z9M28r8z-g62Z=A@mail.gmail.com>
Subject: WiF Transmit Power Control (TPC) Regulatory Requirements?
To: Seth Forshee <sforshee@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: wireless-regdb <wireless-regdb@lists.infradead.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

I wanted to clarify the current state of things.

As far as I know the kernel doesn't have facilities to support TPC or
transmit power control, nor does the wireless-regdb database. And so
in the database we would either omit rules that require TPC, or include
alternative rules (as specified by local regulations) not requiring TPC.
Am I right?

This came up recently with regulatory changes for Singapore and Armenia.

For Singapore [1], the 5.250 =E2=80=93 5.350 GHz range has provisions that =
allow
usage without TPC at a lower power, but the 5.470 =E2=80=93 5.725 GHz does =
not.

For Armenia [2], the updated text (translated by Google Translate) as I
read it requires TPC for all 5 GHz channels.


Thanks
ChenYu

[1] https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-con=
sultations/ict-standards/telecommunication-standards/radio-comms/imdatssrd.=
pdf
[2] https://www.arlis.am/DocumentView.aspx?DocID=3D181829

