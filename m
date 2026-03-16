Return-Path: <linux-wireless+bounces-33304-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK7FJCkluGmNZgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33304-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 16:43:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B329CA5C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 16:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2912300652B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CF3A0EA6;
	Mon, 16 Mar 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivs+YI56"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75239EF30
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675814; cv=none; b=qZ+gqPA12b6RM6oqDm3hGMP1hGtZre4tBNcxlY1956Xk6FnJNFj12cIZT5UrR4rqGlha8PjGtmwZDRpsSiBXvMgyg6Kfd8fH+ugy9W8z0/PwHKTIBaI0m7Ka1HAthy8bmKTjMiYKe6X+2gS59nOrEUKsBzrL3mWXGC3Vw3upO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675814; c=relaxed/simple;
	bh=qnnFKEgSuePVgJSXdU46MBshBKsJgWkb7W+gg/dmsoY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EOBmJQbuDBuEpVe1I39cxJL9hQANBfydgNE4JZ9vm1giXZ4zoBEpQpXc22PqzxNSEM+DGh8ornW8PEjQKVQQE92wJvPVg/NDbX79F4QKdCr5jsizSmWZ70Xc7swyYANfH6B3OpH4xnXs8Qt2B2yTeJGUOwqkKSGlYh2lMehyNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivs+YI56; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso2173709a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773675813; x=1774280613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OUJsBlIgUApje1fV9jF7YVlGvh9bq+NPczCyWOUxzn0=;
        b=Ivs+YI56My6lg0G8Oy7acImGLjkI/+ChldoEN9kNxW9SnMTKbY6ece1AzjLXeCw+pQ
         CmdiV2ZbuRbcZe8pegRW2Mk6HntJegYfpR031Shu+GXLBSEYWnj7JyGTNNmEYIjhmoyb
         Uvn6LTqhUaHF5rIdsHUYSw9/LMXF+RUpWW45eOkqFBS1Tv2bkY1dg2nlXZER+uAkDYuf
         vHypnlngfGf5obHPtu5g0gvn2zx6OIYijx3T86ap6NC0JwrnNloZM1syKOAb2t9/A7MV
         FtF48J7CS4fKyQdUN33K0kAxH2a7l5vhgCvHDlpwmGoanXVgdNhibhV+74NAdOvwOmGJ
         KHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675813; x=1774280613;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUJsBlIgUApje1fV9jF7YVlGvh9bq+NPczCyWOUxzn0=;
        b=nzXPVzrCnAf6fzU5DPNxu9vYD9b20/POh1z91u9DctH47Nh+TCyiRfUJEHGYjgow7H
         jnAYY+dJT6TNVNbR+cnGUGNI/gwkUDg+GNSBRqM6ssSviABWBMN6i/8w0enzXvM0Euqy
         4cpwDjpZ3L/AzfIWN8BUgEejOT7oxeihhlEe3TFqVfL/JeF4NKStBriL7E6fgHgfbKwZ
         BNJnmpa2c4CIR6A6QWu7Y49gIWdG5kR6vuyuabSii31YsbboQNrEnzSdVuqoEB3CGG23
         WjkUrwC3BCr7FgyMDBkYKde4dD5VDFhqKKdiRm1Xe+GXjrOETeVX0KKNRkw9YqYBBn6I
         tpDw==
X-Forwarded-Encrypted: i=1; AJvYcCUE6cE/dTKPZgvD1snXKlBXHuaOyC5RGFHkYotd6T7ek0U6AtZyPDAkGyEuWSKQ2QTxXtcYDFYzalZEsMpiRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPpGTFwIWyndztUY2fzGccFGi+2K500uZ9VFNmCJ6jsd9znAQt
	Cw0rQ5u9HUPzBrFWC27Cp71BBuYiI6JAdiYkoVPzpjxdLjJzReUXU/Pz
X-Gm-Gg: ATEYQzyANrJunzFCBtinqOevAYcESRFGSCVnZHo48uYVSIInD2pZ7HSWYBz1gzwLGnp
	Yoqd7gZ85/p7UT4LnTS1sbvALIbrhNcVSNdWCrGMWflVcZPB+CW/wyQqrEZ2ItuDWgE9x5jBoSf
	FIdJkv4PAcBCn0Wyv40CCotfdaHJuaZirOTMJUU1C8tFtiv+W8KJxNF6X3yJcVUYxHfKFgIH941
	WtgG+3yHxSB1xz+r19yWWFVXyb+zAtOIj05KnQN87FM4eWNUM6xlnLObhgbDCNENp9HIKFCuXkG
	v17PvWk8hATsskka0q1VgzoOfZxw8BmHPde3gMW7OhSVpVgImsbnUefGOsAnZTgzZPl+ifVFfl9
	U0KF3vRX8BrUMfqse3bAc+KhU1Au17Ke/tlTOEGQWL+vcfVW7HuGI+xlzxVCAK8tctkD3FzTYyT
	lGKbnGj+/DBkD3Xzgt8Edrzp6L3an1hr+MeKGxSVNuT4LA1oECpKuzYsFJZk/zGSqOCxJt+k/Qh
	qzkgqPqox396qYn7WsZ53FflNdrGczvRbSC
X-Received: by 2002:a05:6a21:2c12:b0:35d:7f7:4aac with SMTP id adf61e73a8af0-398eccf5230mr12827288637.47.1773675812990;
        Mon, 16 Mar 2026 08:43:32 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb996257sm9417128a12.9.2026.03.16.08.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:43:31 -0700 (PDT)
Message-ID: <b25ebc98-8697-4f1c-989e-fb67d9dc6713@gmail.com>
Date: Mon, 16 Mar 2026 08:43:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
From: James Prestwood <prestwoj@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 kernel@quicinc.com, johannes@sipsolutions.net, jtornosm@redhat.com
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
 <20240813150320.73df43d7.alex.williamson@redhat.com>
 <20240813233724.GS1985367@ziepe.ca>
 <20240815105905.19d69576.alex.williamson@redhat.com>
 <20240815171935.GO3468552@ziepe.ca>
 <fb53b8fd-5d36-4df3-a9e6-fba7c0457e55@gmail.com>
Content-Language: en-US
In-Reply-To: <fb53b8fd-5d36-4df3-a9e6-fba7c0457e55@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33304-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prestwoj@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E5B329CA5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/16/26 7:58 AM, James Prestwood wrote:
> On 8/15/24 10:19 AM, Jason Gunthorpe wrote:
>> On Thu, Aug 15, 2024 at 10:59:05AM -0600, Alex Williamson wrote:
>>
>>>> This is probably the only way to approach this, trap and emulate the
>>>> places in the device that program additional interrupt sources and do
>>>> a full MSI-like flow to set them up in the kernel.
>>> Your last sentence here seems to agree with this approach, but
>>> everything else suggests disapproval, so I don't know where you're
>>> going here.
>> Trapping and emulating is fine.
>>
>> My concern is really only about skipping SET_IRQ.
>>
>> That works because of the assumption that the IMS sources are going to
>> re-use addr/data pairs setup in the MSI CAP.
>>
>> That assumption is frail, and won't work at all under the proper IMS
>> support Linux now has.
>>
>> I really don't want to go down the road and have someone tell Thomas
>> he can't convert the Linux driver to use irq_domain IMS because it
>> will break this stuff here.
>>
>>> I have no specs for this device, nor any involvement from the device
>>> vendor, so the idea of creating a vfio-pci variant driver to setup an
>>> irq_domain and augment a device specific SET_IRQs ioctls not only 
>>> sounds
>>> tremendously more complicated (host and VMM), it's simply not possible
>>> with the knowledge we have at hand.
>> It seems like you have reverse engineered alot of the necessary
>> information though??
>>
>> Maybe there is a more generic approach than a variant driver. If you
>> wanted to use IMS from userspace generically you could imagine some
>> kind of IMS focused "SET_IRQ" in generic VFIO. Where we'd create the
>> needed irq_domains and pass the addr/data pair back to userspace?
>>
>>> I observe that the device configures MSI vectors and then writes that
>>> same vector address/data elsewhere into the device.  Whether the device
>>> can trigger those vectors based only on the MSI capability programming
>>> and a secondary source piggybacks on those vectors or if this is just a
>>> hack by Qualcomm to use an MSI capability to acquire some vectors which
>>> are exclusively used by the secondary hardware, I have no idea.
>> Well at least that should be testable - but it seems crazy if the
>> device has registers for an addr/data pair and then somehow doesn't
>> use the values that get put in them??
>>
>> Copying from the MSI is almost certainly a SW hack because IMS support
>> has never really existed in an OS until now. I think your guess for
>> why it is like this is pretty good.
>>
>>> I do not believe that introducing a vfio device feature that disables
>>> virtualization of the MSI address/data _only_ at the vfio interface
>>> (not to a QEMU VM) provides some implicit support of this device
>>> behavior.  These values are already available to a privileged user in
>>> the host and the same is available for an MSI-X use case by directly
>>> reading the MSI-X vector table.
>> To be clear, I'm not really worried about showing the data to
>> userspace.
>>
>> Userspace just shouldn't be using it to implement an IMS technique!
>>
>> Jason
>
> I see this thread went stale. Wondering if there was ever a final 
> conclusion if this could get fixed for ath11k or not. I tried again on 
> a recent kernel, 6.17, and see the same behavior.
>
> Thanks,
>
> James
>
I addition, I've looked at various kernel version and see no time where 
there was ever a "hw/vfio/pci-quirks.c" file in the tree. I tried many 
versions between 6.17 and 5.11, I don't see the "hw" directory at all.

I'd like to try this patch out, but might need some guidance on what 
kernel version this was meant for and if files may have shuffled around.

Thanks,

James


