Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8749BFCA
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 00:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiAYX6i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 18:58:38 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:56526 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235010AbiAYX6f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 18:58:35 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.27])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 44E7D2A0070;
        Tue, 25 Jan 2022 23:58:34 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ED720600083;
        Tue, 25 Jan 2022 23:58:33 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 757FC13C2B1;
        Tue, 25 Jan 2022 15:58:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 757FC13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1643155113;
        bh=xtSObs9CDjl+WJc2t4EW1ekgi9lXmmCG0LNTxSSfU+4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=lSUV0My10aCSmY3TrFOdISFJdQjkcHmBpHJ8oh3VLY9FIzn+Y35O5hBDpZ4Ln54pd
         wN3f+sL2QUB5SeFmlJDXV+k+0IiqpGmR6t5OWicZeGys03VUReE/oB5z9ISArzlHi3
         6bi9L8west1ZycTKkfk8+RWM8cjmtPuFydexF37g=
Subject: Re: iwlwifi problems, maybe firmware related?
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
References: <92b00b94-aff6-8108-06d1-932b77f9d218@infradead.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <04761964-e3b3-b2f7-78a4-bbc3507ad676@candelatech.com>
Date:   Tue, 25 Jan 2022 15:58:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <92b00b94-aff6-8108-06d1-932b77f9d218@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1643155114-QXHAB_nUntpY
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/25/22 3:08 PM, Randy Dunlap wrote:
> Hi,
> 
> When I boot 5.16 or 5.17-rc1, I get messages like:
> 
> iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
> iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
> iwlwifi 0000:00:14.3: loaded firmware version 67.8f59b80b.0 QuZ-a0-hr-b0-67.ucode op_mode iwlmvm

We see nothing but crashes with the version 67 firmware.  Remove that
from your /lib/firmware/ dir (and make sure version 66 or lower is there),
and reboot and it should work again.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

