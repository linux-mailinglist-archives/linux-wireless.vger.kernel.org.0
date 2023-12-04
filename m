Return-Path: <linux-wireless+bounces-406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C8804136
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 22:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02D01C20AC2
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3DC2E82B;
	Mon,  4 Dec 2023 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="bV+7ca6P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FF0C3
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 13:57:38 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AAF2F34006E;
	Mon,  4 Dec 2023 21:57:35 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 1B51713C2B0;
	Mon,  4 Dec 2023 13:57:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1B51713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1701727054;
	bh=YL628h7K/5M+EdyCbLFzVox94gVS0nqqnuGkK8VQVzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bV+7ca6P3EA0qBntWgUSlxDJQEqgZ+Wje1tXeIH+afYoje6N0fcB3z8W9e77xHCG1
	 O69IQMPhc5jY3pP53m4P1mh79TzO7KnE9/+cPQGr+wx8g4WsvkPSnBGYIuTjI9s7Xq
	 r27SDOENR83j9cDBPkqa0X3UXvGR1CmVa/1KzSlU=
Message-ID: <ae3f3bdb-0de3-e15c-f447-6d1d33478051@candelatech.com>
Date: Mon, 4 Dec 2023 13:57:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/8] wifi: mt76: mt7996: switch to mcu command for TX GI
 report
Content-Language: en-US
To: Shayne Chen <shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Evelyn Tsai <evelyn.tsai@mediatek.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 Benjamin Lin <benjamin-jw.lin@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
 <20231102100302.22160-4-shayne.chen@mediatek.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20231102100302.22160-4-shayne.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1701727057-f0WhdgNOBJci
X-MDID-O:
 us5;at1;1701727057;f0WhdgNOBJci;<greearb@candelatech.com>;dbba72c6a891d3e8767bcea3b0305f22

On 11/2/23 03:02, Shayne Chen wrote:
> From: Benjamin Lin <benjamin-jw.lin@mediatek.com>
> 
> During runtime, the GI value in the WTBL is not updated in real-time. To
> obtain the latest results for the TX GI, switch to use an MCU command.

Hello,

I do not see this callback happening on my system.  What firmware version
is needed for this to work?

And where to find it...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



