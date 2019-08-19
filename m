Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3881949CB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfHSQZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:25:58 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34792 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfHSQZ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:25:57 -0400
Received: by mail-oi1-f171.google.com with SMTP id g128so1763303oib.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/FqBEsosGttHSOLOlkttaCGKpJKkFdfRK1rBW/SrgAw=;
        b=tBg35JcA7TVH9wi4tYs6ye0xVfL9EwCQwIOsSDn1bzA3ANIM35M116NJ83cxiGhdHb
         SITfWuPpBGTNR9O25yazhIxEyq673sTvZzMzJi+VqeINW7zJSgjqX1xriUk4mBPqBojv
         w2d5CJCm0gArYib4aSTKgFm2pbl5lS3laV06tp/jW5wUSOCeHO+4ff72UJGD1ghhhpek
         pTfcLCnbmf2Fv7lyPGNziS0cIGSks3u1DN6IG1R2nNZc3ANDEctA4ouZR54JHx6a8LOm
         htpt0XT3RXuksvtM7ZiLND72KcmXzx0+Lu2o7prQ4PtUtG9PG+RcXSLf5vslmFDuakN4
         dJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=/FqBEsosGttHSOLOlkttaCGKpJKkFdfRK1rBW/SrgAw=;
        b=b2hpC6dt29Mcle5zkBYfUGFVkPYKuOHxI6eHBg72D/Y4aGKu//6kwWINuEuhhw/69T
         QZIm/vhtktTjT60xyQ9NXZegirNi0rhOuQfslpe9kEGoltO4efVdEjoCj8KxVUZfF/do
         SzR8Z9rrhLmDqTA0GYDqYkp7KlbHd1JgPdF4HK8Ee26zVcfSYZNiPEXaEQHHzMAAGpew
         wWrf7KpVIZWQHeCShn3K0cdfhf+HHU9i4+QVUcurohVIAvbqscsqTpsUDNQRdLAvIP3R
         qsxmSl3PZyTcC6vJETsUksyI/ANaSXXtqS1it7ViYh3LHD8fF8PvpeWfxh0NHxuK5x3N
         W6Xw==
X-Gm-Message-State: APjAAAXQNo0ZTq77Quzz33hUVtpJBSmO2d7ShnHSQaBeWf/C37t/a9YE
        SpUCX3VxVK9zwWHOtx8uo4k=
X-Google-Smtp-Source: APXvYqyDNUeQX13WDs/Vq4jQ7PAVUxH3e+b59hQGLUu5VaLXCywebY11Rnul1iFKXLBeIOUwL5FcaA==
X-Received: by 2002:aca:1803:: with SMTP id h3mr13219388oih.24.1566231956382;
        Mon, 19 Aug 2019 09:25:56 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k16sm4332986otj.58.2019.08.19.09.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:25:55 -0700 (PDT)
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Firmware Organization
Message-ID: <53ebd786-7966-1998-951e-b0a0ee7ff39e@lwfinger.net>
Date:   Mon, 19 Aug 2019 11:25:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Prior to now, openSUSE has been packaging kernel firmware as a single entity; 
however, that package has reached a size that has a negative impact on small 
systems. Takashi Iwai has undertaken to split the firmware into a number of 
sub-packages. In a discussion on the developer's mailing list, we identified a 
major issue related to wireless, namely how to ensure that a given user will 
have network access in case their primary PCI device is not workable. To satisfy 
this situation, the following actions have been instituted. Takashi's comments 
are as follows:
------------------------------------------------------------------------------

In short:

- atheros subpackage is split to ath10k and atheros; USB-devices
   belong to the latter

- marvell subpackage is split to marvell and mwifiex; this is just for
   size, as both contain USB-capable WiFi

- realtek and mediatek subpackages aren't changed, as they are already
   small enough

- a new usb-network subpackage is created to contain the rest USB WiFi
   and Ethernet drivers

So, for the USB hotpluggable networks, we have the following packages:
- atheros
- bluetooth
- marvell
- mediatek
- mwifiex
- realtek
- usb-network

------------------------------------------------------------------------------

My questions to the wireless community are (1) Did we miss any issues that would 
hinder network access? (2) Does the above split handle the case of hardware or 
driver failure?

Thanks,

Larry
