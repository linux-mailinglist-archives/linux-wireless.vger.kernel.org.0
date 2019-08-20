Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BDA964AB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfHTPgW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:36:22 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43870 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfHTPgW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:36:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so5417900otp.10
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K5cljF4RAFTH06WrhxtkwXxYYrmqShWT4AgT2edRRK0=;
        b=NLYZmJ5KlkZsjEvk61C/WknVXD8PlAF4QUaM0mEpl1GrXEhWI8/v1losVIyLaFoG6u
         5jltDR/39CN4gN3XJi/JU9x7beOc3CMH+cjH6N1B/7kd+dBDjpQ3ozCrxqIGg1mH+7iv
         mHTHPzSXXW7u0ZkyeXoUMYUXlgc5BGAbuwUB7Ea+FrXEjL5VcSv7Nyxf+YNGjPyYQ4gL
         bl37EnURkJv1f0VPLcDKuKdtton5wU5jbki4o3D0mjoNkKnHw9LPkuDIBoEWBqUmpUwX
         x6As2gKGtRCtLpLxQhVCKChRKEtwjtiL4X6E/cqTSDAP385hOoG4pTzeNRBqeWe5PqhE
         Ro+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K5cljF4RAFTH06WrhxtkwXxYYrmqShWT4AgT2edRRK0=;
        b=p/SU5cTG2R4e3/Um5+j5aMfR7ixfBu+Q8yb0yg846ez2etTrD0LcdztVriQtmVnKde
         E75GysamME5mZH9AUQj12vAkEdUPWoRqEvY7WJfg1ruTTnZgooXdS7Kuvwi02kXKrLg9
         QztOusLSeWIHgO/TtcZ/VIsNtkC00IL43NsC0g+H8igJ3rb60UpOrF7ElT4fsrVo6FrZ
         zPz8QcMSYLfid+oIQm5DBTuvLP4On8NfrUQR6fkZ3ar4JsQOq5yk+fexfdQobLVRmyMs
         OXZGG8btkwnGnGVyYYwZE3RMX/4r7eh0uXX7tleoEPSj/5iOL2M/NJea59PISz2g8S0B
         6ogQ==
X-Gm-Message-State: APjAAAWLinINKsdHXncLeRhR5l2pj8+itcbx5tDQAeAJ4JkNHVxp5dzr
        5B3AX/3b9h/zZMLQoOM59TA=
X-Google-Smtp-Source: APXvYqwz3ANMX3GjtKaSCpcvOd3mQAs08luthFEOHH8BuAwGt4kG1c8Q6lPV6DjUo3JCNIgUpUR8mA==
X-Received: by 2002:a9d:66ce:: with SMTP id t14mr22357308otm.265.1566315381851;
        Tue, 20 Aug 2019 08:36:21 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z17sm6531488oth.48.2019.08.20.08.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:36:20 -0700 (PDT)
Subject: Re: [PATCH 5/5] rtlwifi: rtl8192cu: Fix value set in descriptor
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com
References: <20190812192741.14479-1-Larry.Finger@lwfinger.net>
 <20190820140836.6727960E57@smtp.codeaurora.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <8b4f8edf-fd73-2b88-b985-22658840f409@lwfinger.net>
Date:   Tue, 20 Aug 2019 10:36:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820140836.6727960E57@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/20/19 9:08 AM, Kalle Valo wrote:
> Larry Finger <Larry.Finger@lwfinger.net> wrote:
> 
>> In the process of converting the bit manipulation macros were converted
>> to use GENMASK(), the compiler reported a value too big for the field.
>> The offending statement was trying to write 0x100 into a 5-bit field.
>> An accompaning comment says to set bit 3, thus the code is changed
>> appropriately.
>>
>> This error has been in the driver since its initial submission.
>>
>> Fixes: 29d00a3e46bb ("rtlwifi: rtl8192cu: Add routine trx")
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> I only see patch 5 on patchwork, what happened to patches 1-4?

I pulled them at the last minute, but forgot to rename the subject. Please apply 
that fix alone. The others will follow when I get time; however, they are code 
improvements. Only this one was a code fix.

Larry

