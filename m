Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4370F389D5B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 07:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhETFxW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 01:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhETFxV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 01:53:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA27C061574
        for <linux-wireless@vger.kernel.org>; Wed, 19 May 2021 22:51:59 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x15so15332101oic.13
        for <linux-wireless@vger.kernel.org>; Wed, 19 May 2021 22:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iw7oXAGL2txIiZ1OUDtja7h0fcSe+iLyyVAeBN68CXw=;
        b=P0f5R9+rYc9VskX8XBbdJYIa1n06g1jPmVILIWOiz/mVs55LFnlz+tnS8V9NUIE9ys
         5gHBDDLsvEWiffYEgJ8SljlIL7LEOYl177nD76Q8LgZRw0x6jFL4+md3Mmc3iy++2ZGa
         9RlzWVuNLAplzpxP44RI0l/nzTY5Sj/qgGuBed65XXzfawG8v7ECR/uqx0pnnPIt4uGa
         rmNXaGHOUitsnyqOLE6kVlzysvxkOZM0qIyRBTXMVfkeCbmW2u7BRzZd+IAJ0mfKH32F
         dYgEvwrCusgYzLo/AFM8k2Vsn3x+1xB75trIwArumg6jMoGOy8p2+KKUZq/LthvRald2
         mH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iw7oXAGL2txIiZ1OUDtja7h0fcSe+iLyyVAeBN68CXw=;
        b=VKi2PuVicve6L6rnkpumRgrExLDTfulX2TlbfuZaXNAHDCe5PAgQY06BF3n3VvsItP
         bl8JKJclaG5o6MPQqxtkzcc+h/IZcvtTI0uuSQIDUJVpNVi4djL+3QUMp9jQOQzKseF/
         xGQkD6DagM3+nRfmOCVQ7U0K9sGgN0zR4Q8nnMfWp4n0LEH8STdLD03gsAPtINxzNN13
         XlB3k1itouiWtgsNQsa5xXNWnG4MBrAzi3UAmG41adIaR5MOg+rlueYj1U8RourPgH6x
         1K+29FQlTmhZ87bGv0a7vAvYKPGFjtn938asherEj9u4mXCk7HDJfsdKANeDOWo+9DfW
         1J1A==
X-Gm-Message-State: AOAM533JJ3sVnWaLlqk3RD8XnEka7HWPr5DucN4esOpbGEXakjxQYsmi
        G+9d3cjiNk93FlhqEiTxKIZC6m0B8es=
X-Google-Smtp-Source: ABdhPJxDNEx6MVZF3ZW1pW3BKm646f6CpURQRK9b0e/bD9fDs2TGcmNoifKh+JmtwrHXCI6JSAexGg==
X-Received: by 2002:a05:6808:1448:: with SMTP id x8mr2064067oiv.148.1621489918945;
        Wed, 19 May 2021 22:51:58 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id v19sm441390otq.35.2021.05.19.22.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 22:51:58 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
To:     rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com>
 <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net>
 <1jmF9EMZn2ywrHSGrNCzOUSAzllw9ox-Da2zfbSTnTULlX8Ha8F211TfKuxITBBtkfxiU_R0w7zUeFLdtDj4ejp6qPnCIhFj2U-rsCVNlMg=@protonmail.com>
 <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com>
 <ZJknGMd-LYMAOQNAoIsR9G59_Wlt9uYUPzzJ_v2p3W8kCQ_gIQ_ymF09TV83SN0h5Md0tyzlpIxTjCMkK88gXOkSI5UA_knH6RGUd4ITHrA=@protonmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <d65a162e-9d0c-fff9-65e3-4553a1981ad3@lwfinger.net>
Date:   Thu, 20 May 2021 00:51:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ZJknGMd-LYMAOQNAoIsR9G59_Wlt9uYUPzzJ_v2p3W8kCQ_gIQ_ymF09TV83SN0h5Md0tyzlpIxTjCMkK88gXOkSI5UA_knH6RGUd4ITHrA=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/19/21 4:00 PM, rtl8821cerfe2 wrote:
> On Monday, May 10, 2021 4:49 PM, rtl8821cerfe2 <rtl8821cerfe2@protonmail.com> wrote:
> 
> &gt; On Monday, May 10, 2021 3:06 PM, rtl8821cerfe2 rtl8821cerfe2@protonmail.com wrote:
> &gt;
> &gt; &gt; On Monday, May 10, 2021 4:16 AM, Larry Finger Larry.Finger@lwfinger.net wrote:
> &gt; &gt;
> &gt; &gt; &gt; The only splat that shows in either attachment is due to you not installing the
> &gt; &gt; &gt; regulatory database that sets the channels etc. for your domain. I do not know
> &gt; &gt; &gt; what it is called for your distro - it is wireless-regdb on mine. It is unlikely
> &gt; &gt; &gt; that this is the cause of your problem, but who knows?
> &gt; &gt; &gt; Larry
> &gt; &gt;
> &gt; &gt; I installed the wireless-regdb package. The error message about
> &gt; &gt; regulatory.db went away, but the system still froze.
> &gt; &gt; I'll try the rtw_core parameter disable_lps_deep=1 now.
> &gt;
> &gt; disable_lps_deep=1 did not help.
> 
> The patch set called "rtw88: add scan notify to firmware and refine fw_feature check" may have fixed this problem. I've been running commit 6ccdad5a58e18eac6b1335f05f94bf2b36146e00 from lwfinger/rtw88 for 3 days now with no freeze. It was impossible to go more than a few hours without a freeze before these patches.
> 

Sounds good. I will keep porting the patches submitted to wreless-drivers-next 
to the rtw88 repo at GitHub. I have no idea why this would preclude a system 
freeze, but the Realtek guys might.

Larry

