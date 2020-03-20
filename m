Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A56F18D36D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 17:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCTQAg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 12:00:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38904 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgCTQAg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 12:00:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id t28so6450513ott.5
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2020 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+MmE70xTQ9yLLBs/lJSLdr/xIj7PA+JuJSEcTH8LNeg=;
        b=EFRzCSqv5b7Sp87QpzxTODY6kSXIocR1bDFP66FsZ/sQkwP8ZbzmjXaa+EMWZKzdVI
         Ba/0sBcSMgEj0vtBSZZbvuiDEXbQeMLxFy3UIMRjOvAASZHfPcnRFV5KWxxCi1uaZCM3
         sfF1YMBnSU3tSGwQkqKNvDl9tNrZLvm+3HafbrwFvf+fZ43X4V0DcV54p9UXf3op05WN
         +Am+Jjb8uw7j9ijWpoS3R373arGGypa1hwGAnNM2JJmZSAcMkBeK5jm2eo62ifv86Cz1
         T3uFVeoGbGOH0gdcDYadT/d8ne0aj7JdT7MzM488nrcvRpPja5LPoYnGT79kpyjk+WGA
         VlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+MmE70xTQ9yLLBs/lJSLdr/xIj7PA+JuJSEcTH8LNeg=;
        b=XuquuugZQPTZrBjb+AE63+1rs6ULCJqCdI1Dn1BPprK9GtcXl+u2NRcI0kcfl/HjEs
         5ZlCXufh/8tA4+vINSHPmG1BBzk4eT+FZV6UKiIEywnTgpE7DqwPGmPzVAF8+ILmARRd
         XLxee/z0A+ieN8fR1YN2ddE2EDdmN1nWm5Vz/WcCd8XeccR/oFcL15ADqJfY2Muu5SnF
         murNwen43zhx0DvhxtqV+Tau0Nt3IzqNImAyBRlt82mlQAC074ljLGyhAH0fE7XXhG8c
         k4h7DMYSyY9lRd84vYVEil6dhj7aR1/V98Kr4LM4zRJe0sN7LHKKic8Z0Qg6JjgDoYxk
         x6ng==
X-Gm-Message-State: ANhLgQ2AZmidinB16AGHODNyptxzv24UP0vRHP2WODHwPt1XsKWB1+co
        PT0En3lPdEahIgF4+tvCysE9SWT0
X-Google-Smtp-Source: ADFU+vscLanW56c6oUDcVTqLwFuv/++Ep5P3gMLFSoi9imq2wFNCaHhcpHZdvYrR7HdkXRwZDN6bBg==
X-Received: by 2002:a05:6830:1d52:: with SMTP id p18mr7690484oth.204.1584720034137;
        Fri, 20 Mar 2020 09:00:34 -0700 (PDT)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id n6sm2007542otr.79.2020.03.20.09.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 09:00:33 -0700 (PDT)
Subject: Re: [PATCH] rtlwifi: v88 firmware files for rtl8192cu
To:     Reto Schneider <code@reto-schneider.ch>, dwmw2@infradead.org,
        ben@decadent.org.uk
Cc:     linux-wireless@vger.kernel.org
References: <20200320025229.12084-1-code@reto-schneider.ch>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <83d9a5bb-7802-2fa4-ffff-df318f8ce0e1@lwfinger.net>
Date:   Fri, 20 Mar 2020 11:00:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320025229.12084-1-code@reto-schneider.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/19/20 9:52 PM, Reto Schneider wrote:
> The vendor driver rtl8188C_8192C_usb_linux_v4.0.9_25039.20171107
> includes new firmware files. These were extracted from data statements
> in that driver to form these files.
> 
> Source:
>   File: driver/hal/rtl8192c/usb/Hal8192CUHWImg.c
>   Variables (CONFIG_BT_COEXISTENCE not set):
>   - Rtl8192CUFwTSMCImgArray
>   - Rtl8192CUFwUMCACutImgArray
>   - Rtl8192CUFwUMCBCutImgArray
> 
> Please note: I am unsure about the relevance of rtlwifi/rtl8192cufw.bin
> and if and where from this one should be updated.

New firmware should be sent to linux-firmware@kernel.org, not linux-wireless. 
The material in the first section of this E-mail regarding the derivation of the 
new firmware should be added to WHENCE in the linux-firmware directory when you 
git clone git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/linux-firmware

File rtlwifi/rtl8192cufw.bin is loaded only when the initial firmware file is 
missing or cannot be obtained for some reason. Ideally, it is never used, thus 
you can skip updating it.

Larry
