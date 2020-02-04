Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B0E152150
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2020 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBDTuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 14:50:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56271 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgBDTuW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 14:50:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so4646238wmj.5
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2020 11:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6JA04gqzlOK99JzNgksNDLxM2+WYOhuyFwCSsasycRg=;
        b=svr43D9oXlyyOIc1IEDxyoBcS1ckQD2MSjULN9afs/CR92O1AxhxHS6YYa+mcweg2D
         rvjo3MdHgtFmnIqdcVfUkfshZ06AEgtKXkHNot+8B3EgU0IkyNHFDusl3wo6cAvtWG3/
         EnMHUlT+1LlbpZDagVI/bBQ6pR8vEc3T4U8KUOk1n4FOUsv2wcium+EjAPGQdNIEACik
         H12R72t/fg7EYdp0H07wwnficfQAE/LQYUp2ixTmO0KPrMDxMzrUlNCF01rp0L8LYNg1
         5ndSG2SJROXpGZCKBUktYuPDhywOdVLKBv4e4VvsfUJ+j+QRn1UrEBmnTHhFit2sO3Cp
         Ffbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6JA04gqzlOK99JzNgksNDLxM2+WYOhuyFwCSsasycRg=;
        b=YPe1Be9l9fJy1aBLtb6OY+DRiDUoH9lb7iK/zLrnNy2MzNFzL0D1d3/HvYDwFgxZb5
         CGhJ315XXjmCKeG5KaQmgaBE6nfRJVhWIm1SbmRd2PT4NaKlVPXffd0aJFMlpdXfwkX3
         Tl7DaSv0t+l/W0LV8NpnYFNr8xaG/eZBPtw2A35t9VcdmhW9WPR0psoVVPdELtunhYHT
         V5ifrXCVrKwqz9s9v8qiZTrxb1IudKUmGSbTBUNadXQ1NK81LpHy7U/HX/QOu6+NuT+M
         mJqBU1Ufw0fClYdlN9xA4Do2RpkjG9M7vdMsq36PB+rcdRzBjX9gd8UhWx2PKaEAZw/5
         TGMg==
X-Gm-Message-State: APjAAAXN3F4b9uZdnBx57Z530kSKTxXMp+jGb7pX0Gze8KosB/mIReo4
        ChNgfH3duEzVqhpVaixt695WtkwK
X-Google-Smtp-Source: APXvYqwKbFfmT9e8QUuEJbPDXkDZUrgCNLUfhhixl/gZ/lpjtiWmeDbRp222FaX0HbgtVzL+K9rciw==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr579407wme.153.1580845820398;
        Tue, 04 Feb 2020 11:50:20 -0800 (PST)
Received: from [192.168.43.57] (94.197.120.219.threembb.co.uk. [94.197.120.219])
        by smtp.gmail.com with ESMTPSA id o4sm16140290wrw.15.2020.02.04.11.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 11:50:20 -0800 (PST)
Subject: Re: [PATCH 1/2] staging: vt6656: fix sign of rx_dbm to
 bb_pre_ed_rssi.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
References: <9b3b92d6-3672-00be-d0b5-ccd222236ba9@gmail.com>
 <20200203094222.GM1778@kadam>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <bd20e945-f393-1080-502a-4a92d621cea3@gmail.com>
Date:   Tue, 4 Feb 2020 19:50:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203094222.GM1778@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/02/2020 09:42, Dan Carpenter wrote:
> On Sun, Feb 02, 2020 at 12:27:25PM +0000, Malcolm Priestley wrote:
>> bb_pre_ed_rssi is an u8 rx_dm always returns negative signed
>> values add minus operator to always yield positive.
>>
>> fixes issue where rx sensitivity is always set to maximum because
>> the unsigned numbers were always greater then 100.
>>
>> Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> ---
...

>>  drivers/staging/vt6656/dpc.c | 2 +-
> 
> It appears that the vt6655 driver has the same issue.

In the vt6655 it is not used.

Regards


Malcolm
