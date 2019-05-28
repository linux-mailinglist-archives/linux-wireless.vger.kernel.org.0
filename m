Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9452CE51
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 20:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfE1SQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 14:16:20 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33174 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfE1SQU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 14:16:20 -0400
Received: by mail-oi1-f182.google.com with SMTP id q186so15060321oia.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=q/hwljRwHmaKv1+Ovf6+DYL3Cb1HlF3nNbRBPiEI0to=;
        b=aQeK19Kacthph1CKJSPrtuAgGz+paIr+HW/TeOw+DfP6RIkbylZqoOsfdxzzhkEWdb
         4q6CE81/ZOUVJzHiMOUNMdbPn9HoFrR+WVe0kfTPvDnwWywzD4gOr0Oqir3WRTPb7a/x
         NDq/ulOkT1rWuAGPmM34EtPQZsyp/JpGgQNr1gwCNQK0Abi4IFaN/gBibREFnEpbWqU1
         p7wFvffvB4VepuVMxENHKW84HZtdjHBy4+c6Gtc7FE0nf2gZsJxIoWlGA4FSTeeK7ctu
         cMY+Fn4TwUwMZi9PQFvRTG48WPocLo3mo4e3P6NQJ4iiKlAI6GQ6ehPYfpzFiwb/95BR
         QHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=q/hwljRwHmaKv1+Ovf6+DYL3Cb1HlF3nNbRBPiEI0to=;
        b=sCLA2L8ErR20UJmFmtPz4Q8r8CBmFbUvIUwJpthuLGop6XAoTGXXmVA5QDFpVjCMru
         485Yt0aI4mmNomPNQ9+wL6GwrTGhLYM/4G95pzO160HXjkLUg2om3NN00AU9E/KDWRg1
         YrWF/IgP3aTPAHWUtNGkgrHzXkqddBT3mcX3RYrVvhbUSg7/EnJcwOduXXGGlgEq/paP
         HRFq4TPtHcruVgu4MBsLZxeO7F6cXXcHQVlaB8DF6X/nw+MqvhRrRfxr+A+W9qUVhZPp
         9crz/XFsF79xKTgv0Ei9eiD71MbVVTTlsFW/6HaqVR8PuBeDq2pZ9Vq+1SR3FQ4AEFWO
         vsqA==
X-Gm-Message-State: APjAAAWeuYySWo5thZ66Bn+JmQhbCLhsNRTT6mZVy5cLztAOcFil5RaA
        o64dCa8RSvV74U3IcpbsWdz4kAz4
X-Google-Smtp-Source: APXvYqwixHf8oRPiXfbMsbt1S0AqmF/KANsJJSxOr6XM0ZHwuG/XRPM4HsPsH7dL7sSTthB7JUdG0w==
X-Received: by 2002:aca:af01:: with SMTP id y1mr3384817oie.111.1559067379026;
        Tue, 28 May 2019 11:16:19 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t198sm5371474oih.41.2019.05.28.11.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:16:18 -0700 (PDT)
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Denis Kenzior <denkenz@gmail.com>
Subject: brcmfmac & DEL_INTERFACE
Message-ID: <089d2d0a-a802-3c2b-4993-e17326028d1f@gmail.com>
Date:   Tue, 28 May 2019 13:16:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

We noticed that brcmfmac doesn't support .del_virtual_intf for 
non-p2p/ap interface types.  Any chance this can be added?

We currently remove all wifi interfaces and re-create the needed ones 
with SOCKET_OWNER set, and it would be nice if we didn't need to treat 
brcmfmac specially.

Regards,
-Denis
