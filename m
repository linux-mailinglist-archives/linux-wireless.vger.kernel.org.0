Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFDF1A8FC3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 02:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392415AbgDOAgi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 20:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733064AbgDOAgb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 20:36:31 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13EEC061A0C;
        Tue, 14 Apr 2020 17:36:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m2so1756828otr.1;
        Tue, 14 Apr 2020 17:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GJPdBQ4FDc6YikEOC/twgPI9vNJC4RIs/TAMf7prmrI=;
        b=QdI2+Rh/tNTPpxT3MoOzKtrWD18b26sgK819IABsXs/QT/+7ARTw0AZxv1/SigGMeI
         jxnKYfO7sPYmlLGSYCRGS5wXmnINxcIH0Ka9fUtuxKh0KTKtEItmneQMeMAzdM5c221L
         9BrzyuchS8snTXt6z4hmSuo4W/BhMkKBJzFsrElJaK4p/zg6vTgisckGXwLeVIhDBliP
         p5rsDgs/mwhMzxEDr3VVLxlXy6LVy1uiSG73D/8gZchV084SHJUPJwpoIRgkD5UGi+we
         mS8dS3dS7vMBkpcorhDINjcoiKrdp+nuEjwdpEWD/d3ZRcHMgzmGJkm53jw4cDa7xsOt
         Ngeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GJPdBQ4FDc6YikEOC/twgPI9vNJC4RIs/TAMf7prmrI=;
        b=WtPAMrUP7/Io+Xp4ocsR97old0NOQojf91UVHeUDwe5Hl6oaxlTTglh90NB0VjHTKG
         gIpg81NjDxn1xjrlIGazsNNfEhA5wJ8Mai1CveiSoyMTaMfmkogNae/b8FACjebopl0k
         IJwOSY3VE2u6fMxhYTTnMvmhFYMxIhdzDHU7Gh6vYFEFuMu1brlBZ+2fshSYl0pqV+UH
         LiH7qiSJZ7GpQSdMTC3z6NPiHqNOJPWthH1J3vYMJDbWCxSfPOxhgfqGTAXm7+AbA0g5
         k710RDrWLqUwFb2WhFkUsD5TbEXhE1vk1kSlGmMFY1R6sgyTfEksmWvWfDrN74VTOtBv
         l75w==
X-Gm-Message-State: AGi0PuYhAAWkLHN7TcPnZ/6L4fcFDDb3WCE0lKyT6DitFmhmlvLTRKzc
        yOcl8BaPGwbBHPK1SSbmzwbuP6GN
X-Google-Smtp-Source: APiQypI5Wg0ppQ1y1UVxCZvNwrc4lMa7JViLu4cdHmB7S9QHqVya21da7RZ1lNLn9nxqSpSyz7K39g==
X-Received: by 2002:a05:6830:104c:: with SMTP id b12mr19040290otp.121.1586910990213;
        Tue, 14 Apr 2020 17:36:30 -0700 (PDT)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id y132sm6053933oiy.8.2020.04.14.17.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 17:36:29 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the
 wireless-drivers-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200415080827.30c2c9c1@canb.auug.org.au>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <5b17fefe-f99d-2e4c-ded2-93fd3554687c@lwfinger.net>
Date:   Tue, 14 Apr 2020 19:36:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415080827.30c2c9c1@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/14/20 5:08 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    ec4d3e3a0545 ("b43legacy: Fix case where channel status is corrupted")
> 
> Fixes tag
> 
>    Fixes: 75388acd0cd8 ("add mac80211-based driver for legacy BCM43xx devices")
> 
> has these problem(s):
> 
>    - Subject does not match target commit subject
>      Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> 

Stephan,

I do not understand what you want here. The subject describes what was fixed. 
The error has been in the driver since it was merged. The Fixes: line is a 
description of the commit that introduced the driver file with the error.

Larry

