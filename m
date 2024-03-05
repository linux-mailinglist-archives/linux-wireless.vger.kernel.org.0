Return-Path: <linux-wireless+bounces-4382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6F8721D6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 15:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8347F1F24091
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6986AD4;
	Tue,  5 Mar 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGWKnq0w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189D86AD0;
	Tue,  5 Mar 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649958; cv=none; b=ibJrqKsx7y5Qpn4ZkEZ01saPO0uw4dY0lc5QX+b47aAPnRudJGmirkUoAUCAJHP/1rg3dkW+UKJ4+PUdZlC7on3sE3YNtqgQx3cRECZMU5VcZzKhGkrp+C1eu/sg+gnN+mBrCDSarbTf8Vi4i8W5gwRdpb+PCHjW/8ybt1InYTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649958; c=relaxed/simple;
	bh=5G7PGZMu/aicnTYhUQekw8jRSJeEEv9A1txZjh/ZQaY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=R6Hn1Lk3qbMqvzk/RduxDWoupB2UDjJFM1TLX7ZH5b5kuxXLmbJJJ5i8/qxQnrvNVvahQAIBIfNfKvTqDnjC0yt93L89nZSBSyDmnoGzF0DOc3SIUJsbeQ6pdP1v6yZzX3M9NyLLUoyZ00rWGq8jGDPiWFzfN2Pa67OkRtt11qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGWKnq0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887A2C433C7;
	Tue,  5 Mar 2024 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709649957;
	bh=5G7PGZMu/aicnTYhUQekw8jRSJeEEv9A1txZjh/ZQaY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lGWKnq0wV1cArcaiC2IzwVjteX5G4wZqCSqTxVLf/cpk9GBnqCMW3KwK5rTcGT6bU
	 IYx0ZCL7h2tpD87hypAGK4hAqa2VIxSLFr0jy6brDbetzzDy+e7mQyEG3FEp+FpKXK
	 H+nit08zQDFy0jmjBgYYBRym2UryE6Rzuc979eVouGqJxn6RaX6yBdNnG8Qmkqr2jO
	 Z4QI4gN1zCgfScCNj9AEv4s6YlEX3RUuvpgxboIaaDd6kHJ1eHBKfhM8q/3aIrCKCH
	 0uk2S5D4bNjoR3Fe5D42ycNLoAlM+uLIDcBN3RZ7l5/wq4mw+gmFw1VujtvFPH9DMP
	 dsS55+2k6pCKQ==
From: Kalle Valo <kvalo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Marc Gonzalez <mgonzalez@freebox.fr>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath10k <ath10k@lists.infradead.org>,
  wireless <linux-wireless@vger.kernel.org>,  DT
 <devicetree@vger.kernel.org>,  Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Pierre-Hugues Husson <phhusson@freebox.fr>,  Jami
 Kettunen <jamipkettunen@gmail.com>,  Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
	<b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
	<871q8wk7o3.fsf@kernel.org>
	<3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
	<87wmqoilzf.fsf@kernel.org>
	<20240229-ageless-primal-7a0544420949@spud>
Date: Tue, 05 Mar 2024 16:45:53 +0200
In-Reply-To: <20240229-ageless-primal-7a0544420949@spud> (Conor Dooley's
	message of "Thu, 29 Feb 2024 18:40:57 +0000")
Message-ID: <87le6w7n4u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Conor Dooley <conor@kernel.org> writes:

> On Wed, Feb 28, 2024 at 06:37:08PM +0200, Kalle Valo wrote:
>> Marc Gonzalez <mgonzalez@freebox.fr> writes:
>
>> > As mentioned in my other reply, there are several msm8998-based
>> > devices affected by this issue. Is it not appropriate to consider
>> > a kernel-based work-around?
>> 
>> Sorry, not following you here. But I'll try to answer anyway:
>> 
>> I have understood that Device Tree is supposed to describe hardware, not
>> software. This is why having this property in DT does not look right
>> place for this. For example, if the ath10k firmware is fixed then DT
>> would have to be changed even though nothing changed in hardware. But of
>> course DT maintainers have the final say.
>
> I dunno, if the firmware affects the functionality of the hardware in a
> way that cannot be detected from the operating system at runtime how
> else is it supposed to deal with that?

This is why we implemented in ath10k firmware-N.bin with all sorts of
meta data about the firmware. There are a lots of different ath10k
firmware branches and they have differences which ath10k needs to take
into account. firmware-N.bin tells all that info to ath10k runtime, per
firmware release.

> The devicetree is supposed to describe hardware, yes, but at a certain
> point the line between firmware and hardware is invisible :)
> Not describing software is mostly about not using it to determine
> software policy in the operating system.

For me it feels wrong to use DT for handling WLAN firmware differences.
For example, what if the ath10k firmware in linux-firmware is fixed? Are
we expecting that DT in existing boards is updated? But how is the DT
update going to be synced with linux-firmware releases? Sure, in this
case it most likely won't matter but as a generic solution this looks
very fragile to me.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

