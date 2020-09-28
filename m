Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095A427AC31
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI1KqO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1KqO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 06:46:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7860BC0613CF
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 03:46:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 5so509027pgf.5
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=OQQIlqp6usaAdA6rcvSMQaj5g9YzUjunQ2vExGDZbqI=;
        b=Pv+2n1ewPmOqtj2NXVecPcKtVUUMO+61GSQd5/BIp7EdH+SkMdW/36qN1jvG9W+5TG
         bHNpIISNiO9ws4cX7mZ2btGpVb11aZHyb8eMPnmLxKBZQ9sSsiPaOd2GTujEI4p33HXu
         T1N3E67NZQBvPPIFYg5DORlOR5l4J92GhXXKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=OQQIlqp6usaAdA6rcvSMQaj5g9YzUjunQ2vExGDZbqI=;
        b=QHcXDDVnxQs60EG5NNaPamB2MIwJ8hCxl8uJrgHeJtQ7bZkqhf9E8pZi6SGHL2Azw/
         TXE4GyH1BS/6Qs0zapgHiOUYh6+unkJ/k8zOiledRToyvBI1m8HhTr2JO97IK/kWt1Y+
         NkH876xuhhonuDZoseQqJ1zJsTtIbNvE8q3bEuzF+5OqszYmo5WdYvP6tzrF9kbOBGsp
         AkMsxdetvnZBOQGz+uPwsXJYlbrXptMhulr5yY1vDdtipXgnRFLgR+y8SiahQu0tm5NM
         YO5LeSpNFTVg1kdEMczN3cNGPIzCPIyV8mHJAtl8/spIdzLfGpwxxm7vlL9JMxxPuIrY
         0hJQ==
X-Gm-Message-State: AOAM530Y72D4Es3INFNZDt8JPWX6YXMTGg1iGCEaOkb6/A+XxBy+fmdr
        nlghD31de3hUMFzUJ2Kfo7D+3RPxdhdRou11Q1Gt7dMtRePFvP2NXLD0xx1FR9h7tBnwEe2v5Pf
        R7eYIBchrD/pqSzSFFWnpZJf0h2BUAJXBHlFr5RYsOJ1lu0rhfO5wTYZh3mx8SgoZjdZnTWrYWt
        N6L0w7PTNeGwfevSBICA0=
X-Google-Smtp-Source: ABdhPJyzrWGjZLMlYtNPjSvGzQEly2tyok365/8/D1IzXrb8KwMnlv296kJrRaEOheOA9Bl9F/ykLA==
X-Received: by 2002:a17:902:b713:b029:d2:6153:fb62 with SMTP id d19-20020a170902b713b02900d26153fb62mr1019334pls.28.1601289972570;
        Mon, 28 Sep 2020 03:46:12 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id f5sm975238pfj.212.2020.09.28.03.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 03:46:11 -0700 (PDT)
Subject: Re: WARNING: CPU: 1
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+3640e696903873858f7e@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <000000000000bbdb3b05b0477890@google.com>
 <CACT4Y+arc_qxVnb1+FZUzEM32eDBe7zYgZhcSCgyMUMwKkkeDw@mail.gmail.com>
 <a63808e2-3e76-596c-c0be-64922620820a@broadcom.com>
 <CACT4Y+ZkwMZ3Bu77WGtmOGihNbgspdicEq5d_LA1hDVL=KkZyA@mail.gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <0e2bbc76-1451-a084-dc16-b21c33ca6d82@broadcom.com>
Date:   Mon, 28 Sep 2020 12:46:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZkwMZ3Bu77WGtmOGihNbgspdicEq5d_LA1hDVL=KkZyA@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000006a01e05b05d60c8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000006a01e05b05d60c8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 9/28/2020 12:04 PM, Dmitry Vyukov wrote:
> On Mon, Sep 28, 2020 at 11:31 AM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On 9/27/2020 10:47 AM, Dmitry Vyukov wrote:
>>> On Sun, Sep 27, 2020 at 10:38 AM syzbot
>>> <syzbot+3640e696903873858f7e@syzkaller.appspotmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    748d1c8a Merge branch 'devlink-Use-nla_policy-to-validate-..
>>>> git tree:       net-next
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=13ac3ec3900000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=51fb40e67d1e3dec
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3640e696903873858f7e
>>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599be03900000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149fd44b900000
>>>
>>> Based on the reproducer, this looks like some wireless bug.
>>> +net/wireless maintainers.
>>
>> I don't think so looking at this part of the stacktrace:
>>
>> [   51.814941]  [<ffffffff8465cc95>] macvlan_common_newlink+0xa15/0x1720
>> [   51.833542]  [<ffffffff84662548>] macvtap_newlink+0x128/0x230
>> [   51.858008]  [<ffffffff85b68bfe>] rtnl_newlink+0xe5e/0x1780
>> [   51.925885]  [<ffffffff85b5d32b>] rtnetlink_rcv_msg+0x22b/0xc20
>>
>> Regards,
>> Arend
> 
> That's the trace on the oldest release and the bisection was diverged
> somewhere midway.
> You may see this in the bisection log:
> https://syzkaller.appspot.com/text?tag=Log&x=1474aaad900000
> 
> Initially it crashed with this warning:
> all runs: crashed: WARNING in sta_info_insert_rcu
> 
> This function is in net/mac80211/sta_info.c.

I see. Thanks for the clarification. It was not really obvious where to 
dig for information.

Regards,
Arend

--00000000000006a01e05b05d60c8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
pra5sIx/TR6gNtLG9MpND9zQt5j42hInkP81vqu9DG8lovoPMuR0JVpFRbPjHZ07cLqqbFMVS/8z
53iSewIDAQABo4IB0zCCAc8wDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggr
BgEFBQcwAoZBaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNp
Z24yc2hhMmczb2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNv
bS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAw
RAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2ln
bjJzaGEyZzMuY3JsMCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYD
VR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0O
BBYEFHAaaA+cRo3vYiA6aKVu1bOs4YAYMA0GCSqGSIb3DQEBCwUAA4IBAQCYLdyC8SuyQV6oa5uH
kGtqz9FCJC/9gSclQLM8dZLHF3FYX8LlcQg/3Ct5I29YLK3T/r35B2zGljtXqVOIeSEz7sDXfGNy
3dnLIafB1y04e7aR+thVn5Rp1YTF01FUWYbZrixlVuKvjn8vtKC+HhAoDCxvqnqEuA/8Usn7B0/N
uOA46oQTLe3kjdIgXWJ29JWVqFUavYdcK0+0zyfeMBCTO6heYABeMP3wzYHfcuFDhqldTCpumqhZ
WwHVQUbAn+xLMIQpycIQFoJIGJX4MeaTSMfLNP2w7nP2uLNgIeleF284vS0XVkBXSCgIGylP4SN+
HQYrv7fVCbtp+c7nFvP7MYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNI
QTI1NiAtIEczAgxR3m7Pj6LvQiWjJy0wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IJKxpgMRVWjP7P/tCLlgfsaNbHs9svkRGwTCcgYVGQsZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDkyODEwNDYxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA8mtuUAgJRd5ztAF5M
QawMyxu3sgf0BvoJStdkM7HbZHWWuC1MM17I14feye3kThfuXKOHComtLhsLFXbselnQ/yyMPpv0
OxhokWUQzuvaiqm61EUT7Y4ks+ra7lZiZlPuob2QH+x65BUPNwFXIq7xJ/rofuZua33XGjJvjGeg
Pw0fu0EIHuJR6rzSgUtnJDj7bOj78N9QWwZ8xrloPUp2LwNFnsh/xk/XgqC+Hb2rFupQo6kkyJKA
l8bWu4Y7Y2awIbw2xIQ9e5SZGOFgU43SJGTd5dSbs87JFtylmWTAcCZFrJ/5uPvvdN8GmJlGCX7B
u/JfJBROfjIN6NaFvTCn
--00000000000006a01e05b05d60c8--
