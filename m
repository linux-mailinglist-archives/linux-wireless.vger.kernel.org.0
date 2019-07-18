Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62CE6D146
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2019 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfGRPoy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jul 2019 11:44:54 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38119 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRPoy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jul 2019 11:44:54 -0400
Received: by mail-ot1-f51.google.com with SMTP id d17so29558100oth.5
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2019 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cm2NI46JyKCk22jD5FRP8Q+2LVu+Y1KHnunOdacrABk=;
        b=ElRAxZCltkSzkxzOXfl9NLMIIHcLnvkbVOs7Q3LTpnroOelpJXAo9nqNd1NBKyhdxf
         lLJsRiHh2f6miHjctkxR3qIf0f3AcwYaiei94L8tG1FBF5C3QwmgqrY2Kf8DnTAMlLlH
         K9aeWfGRB9Oz2SAHmIcPKjfyNmyhuvmq8BfdXxmpsXKcTgWtnko6pqVRjfVEHzbmW3Ut
         H82imjGXvN3GpKPJ8HJ5w7p6bpEQi1iHFBCG5zctiHurdttquvHUt61hgw/ygJioQFt1
         qAtMBB9301a2ydi3GZW7seOK6VHm1Cy1C/t1OYViQ5ZZFCNq21+4stl0GOsvd5hvor2D
         KmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cm2NI46JyKCk22jD5FRP8Q+2LVu+Y1KHnunOdacrABk=;
        b=KdbXRrZnlGNh/w7NUN4G/aXPBavQUe8u+gd/rVeNRQMVdW1uL21aql7ETqw2eMM1/z
         d6tHYuq3+F2pH4v3QJoUlWw5EaG8ZUxjRYT85K++HaLn8LZZPirkdL8gRn7AdKBX6KQI
         x2SlDhJVBcMQEbvA16V8ZXPqFDdqKEM7MkM3DIAj0WOjHyv1OVV0ag4IQb5YlyhPmnyg
         REHRr023yky0/cnWchBeQPxtNsiWHQ4NUDgso7z/497gu0CjNcAQ3IGSX6O4h6pHZgdD
         vKYVZFSdIpL61hyWKzrAsHN4t8lmRC8GFHJArhqwl2q0dpe51f8g9dFux1mINytvVBwD
         JLNg==
X-Gm-Message-State: APjAAAXtRJST4ytF8cNfnOUzMfRLfnyG4KJMYZQySmYZJT2cfcFdLCjR
        8TpQYYwHqdIsydVm5AC6V6WEUBBa
X-Google-Smtp-Source: APXvYqyDbKb+DRD58p1/qj+QYCZw4z0SkOIVfcrub4ruZBoZNOFG1ueSv699N6IsUQKxDvoSWc4xnA==
X-Received: by 2002:a05:6830:2098:: with SMTP id y24mr5120516otq.173.1563464693680;
        Thu, 18 Jul 2019 08:44:53 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id o23sm8746539oie.20.2019.07.18.08.44.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 08:44:52 -0700 (PDT)
Subject: Re: RTL8191Su don't switch monitor!
To:     "mysecrct@gmail.com" <mysecrct@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <2019071803353417290810@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <13994f82-adbf-5de9-c011-f6597bfe0ed3@lwfinger.net>
Date:   Thu, 18 Jul 2019 10:44:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2019071803353417290810@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/17/19 2:35 PM, mysecrct@gmail.com wrote:
>      Dear !
> 
> 
> 
>          RTL8191Su worked on ArchLinux, linux 5.2.0
> 
> 
> 
>          Normal use of connecting wifi is no problem. But I want to switch it to promiscuous mode, can't switch.
> I want to ask if there will be an update to solve this problem?
> 
> 
>          My English is not good, so please be sorry for the impoliteness.

You are missing a lot of information.

What is the USB ID of the device? Use the command lsusb to get it.

What driver are you using?

Many of the Realtek drivers have not implemented promiscuous mode. To my 
knowledge, there are no plans to add this mode to these drivers.

Larry
