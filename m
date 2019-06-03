Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FCA32DC1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2019 12:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfFCKjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jun 2019 06:39:19 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:42127 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfFCKjT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jun 2019 06:39:19 -0400
Received: by mail-ed1-f47.google.com with SMTP id z25so203452edq.9
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2019 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sbbLd1XLlENnBmrF4s53/oNZB7ZngZMnTgBYHsHtKfs=;
        b=Q0drrOcoMLVzQa5muJskCLuoQCsF3BDljaEWS8KkVux2fUj2xtM1MLOCyN73VBK88L
         81R4zlwnCFPAZhNO02X8PoZFyBGSC0VxgN+y4jgQ6OBJSqO5rD+wLMS25kJIdawaCbg1
         3P1T41gDc5097/IqnKavhA7MoPoa+GToh/n+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sbbLd1XLlENnBmrF4s53/oNZB7ZngZMnTgBYHsHtKfs=;
        b=EgKpycb7q019UtshqeGzfE1/icbVqsWylK93hIlsKOGMHLkxYXMznxn7VddNWTaSAh
         72inl7tuLTbhIZFACQR+tRIhR2QdPBMU2raKVvwJxvByVqIVPeAD9LgvsWAAGNX616ng
         5yQvewETM7We5A3O9XcTpf84qXhb6qPPIhXQvgV4RsnysLMZGmpCyZ1UHwSSPZXBtLI0
         lukvsyoWn7zkpktmlaEIOI05TJMzdl51R4Rie3Hku38pXQ8PlEDf4ZFpOY5D2k3OIITb
         qvFS2Ty9qAgkKB/JbFwdNSOfwNWVA1JNhEfRMHBNtwnGLMpVctxwqXLLeE61ZewN9Ou1
         y3MQ==
X-Gm-Message-State: APjAAAW3O/i07CcvCdXuBW3BMQgD4O55+JNnVon6C9auHfpc/wax0H9S
        RJyyuObRl3LQmEp9AkACa04r8WRMUk2EEPqsmxV0l1GvSWveE6eOKGhtJ9XWNsEWHAQQKpKb7f6
        qdb7XhtAxYDGd8FJ90t4AJpG1DqEmE60sj896H3NRapJDi03v6zXa4oxJ9Nfi6VuzdxpPXQScd9
        JGS2W6o5d+2AX8sA==
X-Google-Smtp-Source: APXvYqwhwyChvw17nedi7N7xWVsdNAk9jOETBp/z2uoUzWM9uK+HFEmEYnt0Y271ta+HHDIMSbcpMA==
X-Received: by 2002:a17:907:1102:: with SMTP id qu2mr22713036ejb.49.1559558357214;
        Mon, 03 Jun 2019 03:39:17 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id c7sm1106500edl.6.2019.06.03.03.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 03:39:16 -0700 (PDT)
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
 <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com>
Message-ID: <6d40e69c-0cea-cc92-7974-c54d0f70812e@broadcom.com>
Date:   Mon, 3 Jun 2019 12:39:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/27/2019 10:46 PM, Arend Van Spriel wrote:
> On 5/24/2019 8:38 PM, Arend Van Spriel wrote:
>> On May 24, 2019 1:56:43 PM Johannes Berg <johannes@sipsolutions.net> 
>> wrote:
>>
>>> Hi Arend,
>>>
>>> On Mon, 2019-05-20 at 14:00 +0200, Arend van Spriel wrote:
>>>> In 802.11ax D4.0 a new band has been proposed. This series contains
>>>> changes to cfg80211 for supporting this band. With 2GHz and 5GHz there
>>>> was no overlap in channel number. However, this new band has channel
>>>> numbers with a range from 1 up to 253.
>>>
>>> At the wireless workshop in Prague, we looked at this and sort of
>>> decided that it'd be better to put all the 6 GHz channels into the 5 GHz
>>> "band" in nl80211, to avoid all the "5 || 6" since they're really the
>>> same except for very specific places like scanning.
>>
>> Would have liked to be there, but attending is no longer an option for 
>> me. We now have two autistic, non-verbal children and I am the primary 
>> caregiver for the oldest because my wife can't handle him. Guess I 
>> should have checked the workshop notes before working on this :-) Do 
>> you have URL?
> 
> Found the netdev wifi workshop page and looked over the slides quickly, 
> but the notes page is pretty empty ;-)
> 
>> Agree that most functional requirements for 6 GHz are same as 5 GHz. 
>> There are some 6 GHz specifics about beaconing as well.
> 
> This came up in discussion with my colleagues today and I would say from 
> mac80211 perspective there is more to it than just scanning. In short 
> the 6GHz band is for HE-only operation so for example only HE rates may 
> be used. As the bitrates are in ieee80211_supported_band having a 
> separate 6GHz band seems to have a (slight?) advantage.

Hi, Johannes

Any thoughts on this?

Regards,
Arend
