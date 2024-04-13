Return-Path: <linux-wireless+bounces-6276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897318A3D85
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Apr 2024 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BA8282249
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Apr 2024 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7540A44C9C;
	Sat, 13 Apr 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="c3rLPoQp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDB262BD
	for <linux-wireless@vger.kernel.org>; Sat, 13 Apr 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713022827; cv=none; b=sx2VfxOO21w/+n9T5fCCLGUZWFArN73euvd60toBsNKsbxgLTEUBn/9G+VZi/uxbJ7nivSs85vB81415SYKcaXK1mEocklr6W+wbhN+kiwy+9qf+Tvis2gf2PkFZ6lQ29vDmVn+YeR1stlclAz/Oi987QTCC9VU55EYvVD5nK7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713022827; c=relaxed/simple;
	bh=tYqviZf2a7FFRaa4eiO0+lXf17YkmOVHaJ8Je8Idh6o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RhIQrCVzHy3Ej9S14LL5zxCtoE17hLviUXAv6YuhZDwsgDzIFB0xVjYakaqWNlq6C5dly6D8IpxL7hy7nVmWoGpN0cxVPirtV0BRK567KlW2sNFmt6UvNDFBhB1fLvRpqO50EPzwSd4mHva/kllDE6u2MqsYHXDkcjFRTdn5Fwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=c3rLPoQp; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 131F0B80066;
	Sat, 13 Apr 2024 15:40:17 +0000 (UTC)
Received: from [172.20.4.169] (unknown [69.170.33.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 06CE713C2B0;
	Sat, 13 Apr 2024 08:40:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 06CE713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1713022815;
	bh=tYqviZf2a7FFRaa4eiO0+lXf17YkmOVHaJ8Je8Idh6o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=c3rLPoQpX923yCQxuSPiFN0/AIkhAcO6sgEuqJ5xBT8I+ev0JpF2KhX5+QdXBe0+b
	 t55ykmD+xo4CKWan5eiOY0xE/DSXBqTPGHsTzQEod+2LHjOLhidbhvcy9NKjB62hfi
	 DwvSKmv/Gua8IrC5DCyFpTbLZ4sC067IOU9p0qug=
Message-ID: <54807acb-b7dc-851e-27ce-49e09df5e1e4@candelatech.com>
Date: Sat, 13 Apr 2024 08:40:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
 <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
 <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
 <72f491f8-dd3a-0c9e-7490-4d51c86f2102@candelatech.com>
 <cb991a00-fce2-5a3d-c03f-579b44f922f5@quicinc.com>
 <87de72e9-1d3b-b401-a712-9fe8734515b6@candelatech.com>
 <31aa6b18-8ca4-e4ce-f693-e818fc7e6932@quicinc.com>
 <dbd51b99-8472-2641-7493-6b91e384b4b6@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <dbd51b99-8472-2641-7493-6b91e384b4b6@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1713022818-Y4DMTIL-019U
X-MDID-O:
 us5;ut7;1713022818;Y4DMTIL-019U;<greearb@candelatech.com>;e45dbe21c4fc86b950914d8831baea70

On 4/12/24 08:58, Ben Greear wrote:
> On 4/12/24 07:31, Vasanthakumar Thiagarajan wrote:

>> As said, please feel free to propose an alternate solution to address the issue.
> 
> I do not know the particulars of your driver or driver's needs, but at high level:
> 
> *  Leave existing wiphy mapping as is.
> *  Allow adding new combined wiphy(s) on top of groups of underlying physical wiphys.  Sort of
>     like bridges on top of Eth ports.
> *  The combined wiphy would report underlying wiphy's capabilities (for instance, a combined wiphy on top of
>     3 single band phys would report itself as tri-band).
> *  The combined wiphy would add new netlink field listing of its underlying wiphys.  User-space wanting to control the combined
>     wiphy would generally configure the underlying phys (to set 2.4g channel to 6, you'd set the underlying 2.4g
>     wiphy to channel 6)
> *  This should require very minimal changes to user space, except of course for new code to actually utilize
>     the new combined wiphy.
> *  MLO links and any other logic that needs the combined view would live on the combined wiphy (I understand
>     from Johannes' comments this is a needed feature.)
> *  Or user can ignore that combined wiphy entirely and directly use underlying wiphys like we use them currently
>     for sniffers, stations, aps, combinations thereof.
> *  Advanced use case could allow combined wiphy to use subset of underlying radios (add combined wiphy on 2.4 and 5g, use 6g for
>     dedicated mesh backhaul/whatever).
> *  Interesting logic would be needed to deal with constraints to properly share the underlying resources (you could not
>     add 16 ap bssid to 2.4 wiphy and also add 16 other ones to the combined wiphy that also uses 2.4 radio most likely,
>     for instance).  But I think that logic has to be written
>     either way and is not overly worse with this approach.

I had some further thoughts on this approach:

*  If someone has 2 QCA radio cards, and each radio card has 3 phys, would it be possible to have a 6-link MLO
    setup?

*  Could two be200 be combined into a multi-channel concurrent MLO setup with this approach?


*  For multi-phy arrangements like QCA ath12k and MTK7996, I think the default configuration when the driver
    loads should just be the physical phys by themselves (as mt7996, at least, does it now).  This would be fully backwards compatible with
    current user-space and operation.  But the phys would have netlink attributes that lets user-space
    know combined phys (cphys?) can be created on top of them.  User-space that knows about MLO can then
    create the cphy(s) as wanted and build sta/vap/whatever on top of the cphys.

*  For radios like be200 that are already designed to show a single phy to userspace, they would not
    need any significant change.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

