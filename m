Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0FC394A6
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 20:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfFGSuo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 14:50:44 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46332 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfFGSuo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 14:50:44 -0400
Received: by mail-ot1-f44.google.com with SMTP id z23so2769712ote.13;
        Fri, 07 Jun 2019 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mtzNzCUSsxdVxTwVxd+bIYbQvGHAfnBIn5rvBFTyjR8=;
        b=OQXTin5D9dTshUeb7Y4bM60DsbmSUlShMmHN60dZZLL9XCDDB+ORnAUfy+Hr/bRkU4
         Cv0yqr74BU8WBzsrZKhPHtnDdaY0de6HTTVhECsYW3ZFDhfnMueDBif/LMeSAfUlEn3h
         UDnpCbe1YcCpVwHTuEqfOdBNQpHWtDtmXLvZG2FrS/El4fO7hc1A2zcnTOFbu7C5mW/Q
         R8WpqASpMYH4b2zJL1KNqjkz+a3zX08H5kIsv0x12+gOBo0YS8HeS10XU5lcpnd1N66R
         2jI8Uqy8aRSN0derlvny6iWoNLEhVmBJPssrItiTU/pRpjxCLC1oJG2fF5MGcFU9ZEFo
         EXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mtzNzCUSsxdVxTwVxd+bIYbQvGHAfnBIn5rvBFTyjR8=;
        b=H0fcyPqpRI8W7Pll6j4/IMhvldc32YezU/Sf8yGbceUjERIWnOGgbV6OrxxtFS17YJ
         qVUOHZJCkZCwXUsfi5B0HtVTW7CGlc7KIkMM1Zzw2MmE0mwgdgogbxACAHMOkBh+XZfg
         itrHGeEKfY0ARVaJeUReSjD+s0rhl7cFzJENE1DHdzxx9OOnfwpVuCSM1Nn1OQWtNFhM
         Y118iNyOBFXk5Q3IBNJ/x1peKpZhhRn8FFmYaLP1lemZtYxNfZK99cw+/BSW3qypSB4u
         aHvNsi5trtOeSIyXOxHS8C3yVEuSo6sUxteVPNc+uuUpe75p5HpbTkFswXL2or0rPhYZ
         iSOg==
X-Gm-Message-State: APjAAAXrKynw+eRPD+GSkCp2Lc6B+zGiI8i7uEfLfKqVDmiK/gfgoj6z
        mO3cRAX/j9EYKjc9RRJNICHvYLh3
X-Google-Smtp-Source: APXvYqz4kHg4ws3IMu+HwC+T75hwpF0oGqhuGhXdapOMtWtwVH7DgtPV5tHN5bGG1FLCCtTfGvS7mw==
X-Received: by 2002:a9d:7683:: with SMTP id j3mr20795572otl.290.1559933443940;
        Fri, 07 Jun 2019 11:50:43 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id w22sm1034238otp.73.2019.06.07.11.50.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:50:43 -0700 (PDT)
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
To:     Christoph Hellwig <hch@lst.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
 <20190607172902.GA8183@lst.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <034e6860-8fa8-0510-96c2-0cf6e6a04868@lwfinger.net>
Date:   Fri, 7 Jun 2019 13:50:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607172902.GA8183@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/7/19 12:29 PM, Christoph Hellwig wrote:
> I don't think we should work around this in the driver, we need to fix
> it in the core.  I'm curious why my previous patch didn't work.  Can
> you throw in a few printks what failed?  I.e. did dma_direct_supported
> return false?  Did the actual allocation fail?

I agree that that patch should not be sent upstream. I posted it only so that 
anyone running into the problem would have a work around.

I will try to see why your patch failed.

Larry

