Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E36ADFB6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 21:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405898AbfIITzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 15:55:09 -0400
Received: from www.zeus07.de ([194.117.254.37]:38544 "EHLO mail.zeus07.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730465AbfIITzI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 15:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=ibk-consult.de; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=kS2fMAluIZgAkK
        /YjPLnUFnJL5zE5IUQ9kxF7pUBagE=; b=pQgKT8f46Uyqx5VLFU0jNzCseY0DBA
        gYbW+MHSSvMSoJ1HWhSt4RJSdhProl290ofP3z03aPN2uf43rZ6OFfPZg/DHA7mj
        7nMIhKK1VHxdxsD9ZoH3XQwqLzZvViduo/2jFIHjWFysXOKGKXgCp726Jjfbbbjk
        srtfizdO4r/v8=
Received: (qmail 4172 invoked from network); 9 Sep 2019 21:55:06 +0200
Received: by mail.zeus07.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 9 Sep 2019 21:55:06 +0200
X-UD-Smtp-Session: l3s7167p2@Y6oUKiSSIJNNAw2m
Subject: Re: Fwd: Asus x540m - RTL8723befw.bin and rtl8723befw_36.bin
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Cc:     kyle@kernel.org
References: <ql15114vjvsd2m1ywuv1u1b1.1565285708045@email.android.com>
 <12353dc2-5beb-7d65-54ee-5dd6cdd4fc47@ibk-consult.de>
 <746c6c58-04a1-42b6-9657-197677d173cd@lwfinger.net>
 <dcea9c36-e9c5-a80a-ec81-eb3454af4425@ibk-consult.de>
 <c41ed218-3dff-0a3a-796a-a63dd4cbc960@lwfinger.net>
From:   Joerg Kampmann <kampmann@ibk-consult.de>
Message-ID: <ee9f0bb6-baab-4eea-ac12-6e623d0ec598@ibk-consult.de>
Date:   Mon, 9 Sep 2019 21:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c41ed218-3dff-0a3a-796a-a63dd4cbc960@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks a lot, Larry. this computer is not mine. it belongs to a refugee 
coming from Georgia (formerly ussr) ... She got this ASUS stuff from a 
company in Litvania ... strange history. I am working on that problem on 
a voluntary base ... and this started already 3 weeks ago ...


Am 09.09.19 um 18:15 schrieb Larry Finger:
> On 9/9/19 11:00 AM, Joerg Kampmann wrote:
>> This seems to be very strange. Does anybody have an explanation for 
>> this strange behaviour?
>
> I just searched the entire kernel source for the message "firmware is 
> too big". The only place it was found was 
> "drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c: mfc_err("MFC firmware 
> is too big to be loaded\n");". I do not think that is the problem. :)
>
> Have you tried any other distros? A Live Medium should let you know if 
> it has the same problem.
>
> Larry
>
>
-- 
=============================================================================
Joerg Kampmann, Dr. Dipl.-Phys - IBK-Consult for Climate Physics -
D-31228 Peine +49-177-276-3140
www.ibk-consult.de - www.kampmannpeine.org
www.xing.com/hp/Joerg_Kampmann
www.xing.com/net/mathe
www.researchgate.net/profile/Joerg_Kampmann - https://independent.academia.edu/J%C3%B6rgKampmann
===============================================================================
This e-mail may contain confidential and/or legally protected information.
If you are not the intended recipient (or have received this e-mail in
error) please notify the sender immediately and delete this e-mail. Any
unauthorized copying, disclosure use or distribution of the material in
this e-mail is strictly forbidden.
Diese E-Mail enthält vertrauliche und/oder rechtlich geschuetzte Informationen.
Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich
erhalten haben, informieren Sie bitte sofort den Absender und loeschen
Sie diese Mail
===============================================================

