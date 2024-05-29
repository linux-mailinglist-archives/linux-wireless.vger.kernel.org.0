Return-Path: <linux-wireless+bounces-8244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5C58D2ACB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 04:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84FF282698
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 02:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E615B0E0;
	Wed, 29 May 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoOiWnAR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D842AEFD;
	Wed, 29 May 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949737; cv=none; b=WSoFdYdCfAnIKN+SuXgwJ6yaUVNZblEr9xBnKRGbg0uT5W7qWQkISRxXcsVUMyyEG2pRCnCttWtr6Bfq4BbcTswqY5lEibTYWcC+Kgdsz7roejCSjymjmmYreduzgd14nanU6ZLiyHXKRjwt7nAcdkDcp7tezZYpxmzKo1nx/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949737; c=relaxed/simple;
	bh=ZwvUORaxzc0vrGFqCdwHpqmj4IP8E9GxhkTzYLGO4/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKFcxhP+LKrwcowqqH3mdQiF6MqOmVm7swi/3UKGrWQYm+j7AoCAi5QN/qG0KQFuDPYl9/VRW6WDoSGFjmQKjG6dIKu2CvLwkHpRF+cKYfO0YPZJe8K41uX6Vca4S0iNM0wosk/VH7Qro5xY2HhvZ6LGTYn5ucZlziilP/2SAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoOiWnAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD459C3277B;
	Wed, 29 May 2024 02:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716949737;
	bh=ZwvUORaxzc0vrGFqCdwHpqmj4IP8E9GxhkTzYLGO4/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KoOiWnARhGc9ZaTdHga34C//fejSGA1/f5faW0EmsorMft6hRkhydRTmN/aHLoMb+
	 igEjT3Zo5OXCK8ab8I41PJXqG2UGKzdQXOrHSV/hDEmuSzey92Nfu2dQnGpk9hw2Ox
	 eHLiVveiY8oS4XULy8Q2gH0gby1KpqtcDsD+dzJol2jeBuHv4gH7dQQ9MniEmxY49E
	 KxCL/HSqe3xbuU/B1wgi/7BtrQYL3or3DwxZw5g5AYtyXavyz8NSt7VcoMRy4NPhCG
	 yJ31hRi0SYVuR/ZKhYhyuJ58vc3Cg2yvse7wUcU3mOtkrcBleCdu86PNrMl4Clizrj
	 MSag0j0ZzHLLA==
Date: Tue, 28 May 2024 21:28:54 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, neil.armstrong@linaro.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Loic Poulain <loic.poulain@linaro.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/12] soc: qcom: add firmware name helper
Message-ID: <pd3jgsd2ps73qd2h4rdxavd4zmyeqrqmslkbuwtgwlotm4tzgb@bb5japc6opcq>
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
 <20240521-qcom-firmware-name-v1-1-99a6d32b1e5e@linaro.org>
 <a45b53f3-b2a5-4094-af5a-1281e0f94d2f@linaro.org>
 <CAA8EJprxYsoug0ipRHTmX45vaFLzJCUF0dQWOc=QLs4y6uZ1rA@mail.gmail.com>
 <878r03csxn.fsf@kernel.org>
 <CAA8EJpqkgpCb57DGka0ckbPz=2YiaHzxmiNzG39ad5y6smgO5A@mail.gmail.com>
 <Zk52IHqAfOnVDm50@hu-bjorande-lv.qualcomm.com>
 <CAA8EJpogG5wW2mUUkYFtnnZLMVuneU4Wie6GBfYytSYe0zQ77Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpogG5wW2mUUkYFtnnZLMVuneU4Wie6GBfYytSYe0zQ77Q@mail.gmail.com>

On Mon, May 27, 2024 at 02:42:44PM GMT, Dmitry Baryshkov wrote:
> On Thu, 23 May 2024 at 01:48, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >
> > On Tue, May 21, 2024 at 03:08:31PM +0200, Dmitry Baryshkov wrote:
> > > On Tue, 21 May 2024 at 13:20, Kalle Valo <kvalo@kernel.org> wrote:
> > > >
> > > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
> > > >
> > > > > On Tue, 21 May 2024 at 12:52, <neil.armstrong@linaro.org> wrote:
> > > > >>
> > > > >> On 21/05/2024 11:45, Dmitry Baryshkov wrote:
> > > > >> > Qualcomm platforms have different sets of the firmware files, which
> > > > >> > differ from platform to platform (and from board to board, due to the
> > > > >> > embedded signatures). Rather than listing all the firmware files,
> > > > >> > including full paths, in the DT, provide a way to determine firmware
> > > > >> > path based on the root DT node compatible.
> > > > >>
> > > > >> Ok this looks quite over-engineered but necessary to handle the legacy,
> > > > >> but I really think we should add a way to look for a board-specific path
> > > > >> first and fallback to those SoC specific paths.
> > > > >
> > > > > Again, CONFIG_FW_LOADER_USER_HELPER => delays.
> > > >
> > > > To me this also looks like very over-engineered, can you elaborate more
> > > > why this is needed? Concrete examples would help to understand better.
> > >
> > > Sure. During the meeting last week Arnd suggested evaluating if we can
> > > drop firmware-name from the board DT files. Several reasons for that:
> > > - DT should describe the hardware, not the Linux-firmware locations
> > > - having firmware name in DT complicates updating the tree to use
> > > different firmware API (think of mbn vs mdt vs any other format)
> > > - If the DT gets supplied by the vendor (e.g. for
> > > SystemReady-certified devices), there should be a sync between the
> > > vendor's DT, linux kernel and the rootfs. Dropping firmware names from
> > > DT solves that by removing one piece of the equation
> > >
> > > Now for the complexity of the solution. Each SoC family has their own
> > > firmware set. This includes firmware for the DSPs, for modem, WiFi
> > > bits, GPU shader, etc.
> > > For the development boards these devices are signed by the testing key
> > > and the actual signature is not validated against the root of trust
> > > certificate.
> > > For the end-user devices the signature is actually validated against
> > > the bits fused to the SoC during manufacturing process. CA certificate
> > > (and thus the fuses) differ from vendor to vendor (and from the device
> > > to device)
> > >
> > > Not all of the firmware files are a part of the public linux-firmware
> > > tree. However we need to support the rootfs bundled with the firmware
> > > for different platforms (both public and vendor). The non-signed files
> > > come from the Adreno GPU and can be shared between platforms. All
> > > other files are SoC-specific and in some cases device-specific.
> > >
> > > So for example the SDM845 db845c (open device) loads following firmware files:
> > > Not signed:
> > > - qcom/a630_sqe.fw
> > > - qcom/a630_gmu.bin
> > >
> > > Signed, will work for any non-secured sdm845 device:
> > > - qcom/sdm845/a630_zap.mbn
> > > - qcom/sdm845/adsp.mbn
> > > - qcom/sdm845/cdsp.mbn
> > > - qcom/sdm485/mba.mbn
> > > - qcom/sdm845/modem.mbn
> > > - qcom/sdm845/wlanmdsp.mbn (loaded via TQFTP)
> > > - qcom/venus-5.2/venus.mbn
> > >
> > > Signed, works only for DB845c.
> > > - qcom/sdm845/Thundercomm/db845c/slpi.mbn
> > >
> > > In comparison, the SDM845 Pixel-3 phone (aka blueline) should load the
> > > following firmware files:
> > > - qcom/a630_sqe.fw (the same, non-signed file)
> > > - qcom/a630_gmu.bin (the same, non-signed file)
> > > - qcom/sdm845/Google/blueline/a630_zap.mbn
> >
> > How do you get from "a630_zap.mbn" to this? By extending the lookup
> > table for every target, or what am I missing?
> 
> More or less so. Matching the root OF node gives us the firmware
> location, then it gets prepended to all firmware targets. Not an ideal
> solution, as there is no fallback support, but at least it gives us
> some points to discuss (and to decide whether to move to some
> particular direction or to abandon the idea completely, making Arnd
> unhappy again).
> 

I understand the desire to not put linux-firmware-specific paths in the
DeviceTree, but I think I'm less keen on having a big lookup table in
the kernel...

Regards,
Bjorn

