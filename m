Return-Path: <linux-wireless+bounces-17052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC95A00A8C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 15:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24FA17A1F88
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58E71FA270;
	Fri,  3 Jan 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HPzQaNPK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2421FA8EF
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914704; cv=none; b=mq0Jry6UohDdcDOw4R3p90VWcKi/c3T1nRVT63Sb4hgSvamPSJ6W3tpfeKtojmPY6bfb6s5XWhraG5q7uLY8z3OzXdWmWRXGq8wkzeTrxiE7/iLliwbSFuo4IOSQeHp3dx3HzDuQg420j2AM4FIsx4qXCPLxweBgLgjccZ1OsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914704; c=relaxed/simple;
	bh=Fe6qFIofTeLLtNfSn6+xkHpbsXHW37Fb7CK/4DFE27I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhRtTz4tYjss1MQeKJ0HdSSontGg3qk6QH5OqziJzocX3EKiJZzjGkM2WPhbjOSPi+dvVKOfriDajGwVLL5617ks2Opo4WjeKull5gpBhFw5ms7+Y8piSzd/ZIuoDJQIEzVXpj2bqZEDN9KO7zrcBIQZqSv7fOUvNKfhxOlMtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HPzQaNPK; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4679eacf25cso66394891cf.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jan 2025 06:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1735914701; x=1736519501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZz1gAr6AH9VZR9mcSijrSsgtvQXf/lr7rOewXx+J4E=;
        b=HPzQaNPKf3GjOEtZt82O9sdlm2IXiffXpbFVF9FMiEzEXF0r+pUl5IUN9peEZJJnLA
         CqobV0VOYVT8D3WhvgyF0tDX1c171qJEBeIj7PLVvNQL1DcDoscCbuM8RwFY/TBKaOeR
         ulpKBrSD9W5wGw7w1XL9WWklNdl52qrYJaGoKRoob/+hrm75ltY7xxD4Nht1pr2V531u
         Xgvnlf4CYPHALH+J8Wi5PR1/8Dsg870FWdKIF3BcrgYNTSXaYOSm+s+TcH6qeZpYWrjJ
         r3jb44kW8RVSB6NeReJJBbQuzyPVM8O1IiDhIRt3nnrDeQRgNDg+20MnWvis9T/AtfQ1
         jVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735914701; x=1736519501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZz1gAr6AH9VZR9mcSijrSsgtvQXf/lr7rOewXx+J4E=;
        b=VxnjlVVxprpf9u2JCO8qovnmexTI3HUyxs23tRmQlK4x+fdz6DS08QZ+XLDPzRfiel
         dfXgyVb8SiwmyaOC0TFJddkRfjGRfc+0QDuBcNNxivt4owQy1X7wiaBrp9FMivkdeWbw
         PVpZEKGk/t4bgSxshvea6PRKgauEWeDCqojTf8TP53C8k/UmL8nT6gv260CpeXERr+S5
         4VCJejd4V/hMG9ugqITmbrSsZXMBxWRjlJB07/V/rD0aI31UXBfqiX7dtXLazyF0YBhh
         pZDFlZ2FV9YQITYh9ytFsSuKLmpXFDWVMbnDwPXFGMHEYryQZFAbqyBHqBdOg2qsyrVL
         Ediw==
X-Forwarded-Encrypted: i=1; AJvYcCVF7xBWMmBB6QEa/BN0EhotzA9Yu5sJhPiWjpizIonPs1zje6T9z/XpxtONtDwvaWjrdK3K16borTKHCWFCqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6K3wV7a2GE9jWbyy2XoFsRR20q1YCAytJsEwxFAx5uEto7lEw
	74l4K9XguyonaDEKnsOOAJHqk5m9NvzTA/NrSONu+FsxRYvtDHH9g7EXH/3UDkwr8c8t3YUrIEF
	m
X-Gm-Gg: ASbGnct0jaPGdW7N8xCL8D9RrLQM46XzBMwNUeIJNknBjryWG4UDvv/92AiTtsuJExn
	q2P9BzwR/stjl06ZlCTZE8wNCkbY0xmYhk/vqDxsPMp0qKrAEGNYpCkthTkggWVMl2MfQE4zaCF
	ZTaNj5aTdvO+QSyXjG/LxjXq7LcQNJLy9UvVGe7zOLRW+TDCYerdXxYyWpetyjPY5IJK6pMyfrE
	a7K0woDHWleNVKs1DEX1BcOHvUihFTTVGZmv3O91cosSju8cZbd6YpqgG8iLtxpATYw7M9GfbHr
	bn+0/pGj99uaheoM6ieibnb4gDTdCQ==
X-Google-Smtp-Source: AGHT+IGiZCm/3QIaBTSxT82414Bd+tcXwlZF1XMVW0fnnGbWf0zxnCHe0OPTUe/2fE3HXHDT4SXs4g==
X-Received: by 2002:a05:622a:10c:b0:467:68a2:cb55 with SMTP id d75a77b69052e-46a4a8eb7eemr795329811cf.28.1735914701493;
        Fri, 03 Jan 2025 06:31:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e64cf47sm146147721cf.3.2025.01.03.06.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 06:31:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tTiiA-00000000iUS-1wLH;
	Fri, 03 Jan 2025 10:31:38 -0400
Date: Fri, 3 Jan 2025 10:31:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20250103143138.GC26854@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <87r0aspby6.ffs@tglx>
 <03fdfde8dc05ecce1f1edececf0800d8cb919ac1.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03fdfde8dc05ecce1f1edececf0800d8cb919ac1.camel@infradead.org>

On Fri, Dec 13, 2024 at 09:10:30AM +0000, David Woodhouse wrote:

> <fantasy>
> A: The guest OS just hands the device a standard MSI message encoding
> the target guest APIC ID and vector (etc.), and the IOMMU does the
> rest. Nothing 'intercedes' between the guest and the device to mess
> with that MSI message.
 
> /me wakes up...

Well, I share your dream at least. :\

Have the VMM shadow the virtual interrupt remapping tables and assign
it to the phyiscal remapping so that the physical addr/data pair
doesn't change. Driving interrupt routing fully via the remapping HW
and not via MSI interception.

IIRC Alex had a patch series for qemu to capture and rewrite the ath
non-standard MSI locations, so virtualization worries should not block
moving ath to use the device-specific MSI..

Jason

