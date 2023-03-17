Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14F6BF078
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 19:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCQSMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 14:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQSMv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 14:12:51 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB0CB854F
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 11:12:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54184571389so109213217b3.4
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679076769;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n7ALuvK9jC2abLihsBkpSQ/z+K1o6QIIi0fEnkvgzAE=;
        b=CVjmSAZhzNCMCR9W85EaGR+H7NolEsz0lupggyUPqGgQBO0rYa3TFe8Wr9bv65YXa9
         jVGbGcXB4bQuseWnx4awa+80453KBJmaq968eLTeqn+mHfCrCjlUg7w41jJX3NRBHKr0
         5Lw667jefk88FgLIULvxZ8KJMtjVBmh5nHT2qB5Z59UxSJ5Vc4US5S5crddLV6qcJdn1
         knTgxs4hQEZN5/gTd8oZ2xNCGGU38Vdtm4QsqV1lwSzXYZmFHcP6+EEmD5DZoaCPKHOu
         NJffiNIO9NT6IEYakvLD8ypf/OT5FDAjHqMAsJFjfOaMYsXOwijO3gi9vy0U01fEaRsm
         CoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679076769;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7ALuvK9jC2abLihsBkpSQ/z+K1o6QIIi0fEnkvgzAE=;
        b=KhpwlOdeXbjL0OFDt0v7NGZacgh3seefCc2ymk+u70v8gIYvWzg0jUOedqtuI5SAyz
         gqUXs9k54GfLsW1d4GvAXJRk1u6LtYpcG8XnhqeeG5caPBjed/VvSBFj+LUhMdvAO0M7
         eJHSScLJQ14J6lG04GZmdox8vprEv0vT7B3+m6puBtTZD0nyzs/WaJk2YQZAtSRtPPco
         BWabZuqjRg+j3vW+QJQ3WijLIbpLKpItSBlZUGChM+Yr4QJ5zd8Xp0k8aZ8FJtWauYHM
         0cbDCalCLZtiE9KJR6ezqOvCJscbKetHsAwTJ5Gbvraljj4CtLgpqGnR7Vmo9+2BR0UI
         z/Zg==
X-Gm-Message-State: AO0yUKVbhrkoGbA24Mh/bpi7uOq2Q7TM6JDBKR2cH4jRBPcGylIB1AlI
        JWq3Dr6LoAYFUp0fIHM2tV8d81k7CK5neLk/IUeTQl/gCQ==
X-Google-Smtp-Source: AK7set/OmYxx6t4mdBj+fz1CGQ5TAVMldC6FhBE4M1k7+MOwYjQg0szwIi1rfgngWILWP0I/+rthLenwVzAgLXkl5VM=
X-Received: by 2002:a81:af63:0:b0:52e:d380:ab14 with SMTP id
 x35-20020a81af63000000b0052ed380ab14mr3666370ywj.3.1679076768872; Fri, 17 Mar
 2023 11:12:48 -0700 (PDT)
MIME-Version: 1.0
From:   Tim K <tpkuester@gmail.com>
Date:   Fri, 17 Mar 2023 14:12:35 -0400
Message-ID: <CA+shoWQ7P49jhQasofDcTdQhiuarPTjYEDa--NiVVx494WcuQw@mail.gmail.com>
Subject: rtw88: kernel NULL pointer dereference
To:     linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005d396b05f71c865e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000005d396b05f71c865e
Content-Type: text/plain; charset="UTF-8"

Hello again all,

I've been running a few rtw8822bu dongles in monitor mode doing a
packet capture on an STM32, running Linux 5.15. It's been fairly
stable over a few days, but I checked back in on it and found this in
the log.

Any thoughts on what could have caused this? This is from lwfinger's
GitHub repo at 4bede29 (I believe.)

[406207.728602] 8<--- cut here ---
[406207.730533] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[406207.740137] pgd = 40e434d7
[406207.741665] [00000004] *pgd=00000000
[406207.745300] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[406207.801313] CPU: 0 PID: 23145 Comm: kworker/u4:2 Tainted: G
   O      5.15.24 #13
[406207.809516] Hardware name: STM32 (Device Tree Support)
[406207.814783] Workqueue: rtw88_usb: rx wq rtw_usb_rx_handler [rtw88_usb]
[406207.821397] PC is at rtw_rx_fill_rx_status+0x40/0x278 [rtw_core]
[406207.827604] LR is at rtw_rx_fill_rx_status+0x3c/0x278 [rtw_core]
[406207.833666] pc : [<bf324cac>]    lr : [<bf324ca8>]    psr: 400f0113
[406207.840043] sp : c5379e20  ip : c5379eb8  fp : 00000001
...
[406208.084918] [<bf324cac>] (rtw_rx_fill_rx_status [rtw_core]) from
[<bf3c6b44>] (rtw8822b_query_rx_desc+0x10c/0x19c [rtw_8822b])
[406208.096524] [<bf3c6b44>] (rtw8822b_query_rx_desc [rtw_8822b]) from
[<bf416920>] (rtw_usb_rx_handler+0x6c/0x16c [rtw88_usb])
[406208.107820] [<bf416920>] (rtw_usb_rx_handler [rtw88_usb]) from
[<c01455cc>] (process_one_work+0x1dc/0x588)
[406208.117570] [<c01455cc>] (process_one_work) from [<c0145e04>]
(worker_thread+0x5c/0x568)
[406208.125790] [<c0145e04>] (worker_thread) from [<c014c230>]
(kthread+0x144/0x160)
[406208.133310] [<c014c230>] (kthread) from [<c0100130>]
(ret_from_fork+0x14/0x24)
...
[406208.186520] ---[ end trace 140c234232a74c11 ]---

Kind regards,

Tim

--0000000000005d396b05f71c865e
Content-Type: application/octet-stream; name="kernel.log"
Content-Disposition: attachment; filename="kernel.log"
Content-Transfer-Encoding: base64
Content-ID: <f_lfcuw9ux0>
X-Attachment-Id: f_lfcuw9ux0

WzQwNjIwNy43Mjg2MDJdIDg8LS0tIGN1dCBoZXJlIC0tLQpbNDA2MjA3LjczMDUzM10gVW5hYmxl
IHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRk
cmVzcyAwMDAwMDAwNApbNDA2MjA3Ljc0MDEzN10gcGdkID0gNDBlNDM0ZDcKWzQwNjIwNy43NDE2
NjVdIFswMDAwMDAwNF0gKnBnZD0wMDAwMDAwMApbNDA2MjA3Ljc0NTMwMF0gSW50ZXJuYWwgZXJy
b3I6IE9vcHM6IDUgWyMxXSBQUkVFTVBUIFNNUCBBUk0KWzQwNjIwNy43NTA2OTldIE1vZHVsZXMg
bGlua2VkIGluOiBjbWFjIGFlc19hcm0gYWVzX2dlbmVyaWMgYWVzX2FybV9icyBjcnlwdG9fc2lt
ZCBjcnlwdGQgYWxnaWZfc2tjaXBoZXIgc25kX3NvY19oZG1pX2NvZGVjIHRkYTk5NTAgcnR3ODhf
ODgyMmJ1KE8pIHJ0d184ODIyYihPKSBydHc4OF91c2IoTykgcnR3X2NvcmUoTykgcnQyODAwdXNi
IHJ0MngwMHVzYiBydDI4MDBsaWIgY3JjX2NjaXR0IHJ0MngwMGxpYiBtYWM4MDIxMSBsaWJhcmM0
IHNuZF9zb2Nfc2ltcGxlX2NhcmQgc25kX3NvY19zaW1wbGVfY2FyZF91dGlscyBidHVzYiBidHJ0
bCBidGJjbSBidGludGVsIGJsdWV0b290aCBjZmc4MDIxMSBlY2RoX2dlbmVyaWMgZWNjIGxpYmFl
cyBldG5hdml2IGdwdV9zY2hlZCBzdG0zMl9jcmMzMiBzdG0zMl9oYXNoIGNyeXB0b19lbmdpbmUg
c25kX3NvY19zdG0zMl9pMnMgc25kX3NvY19jb3JlIHN0dXNiMTYweCB0eXBlYyBzbmRfcGNtX2Rt
YWVuZ2luZSB0ZGE5OTh4IHNwaV9zdG0zMiBzdG0zMl9jZWMgc25kX3BjbSBzbmRfdGltZXIgc25k
IHNvdW5kY29yZSBtc2NjIGlwX3RhYmxlcyB4X3RhYmxlcyBpcHY2Cls0MDYyMDcuODAxMzEzXSBD
UFU6IDAgUElEOiAyMzE0NSBDb21tOiBrd29ya2VyL3U0OjIgVGFpbnRlZDogRyAgICAgICAgICAg
TyAgICAgIDUuMTUuMjQgIzEzCls0MDYyMDcuODA5NTE2XSBIYXJkd2FyZSBuYW1lOiBTVE0zMiAo
RGV2aWNlIFRyZWUgU3VwcG9ydCkKWzQwNjIwNy44MTQ3ODNdIFdvcmtxdWV1ZTogcnR3ODhfdXNi
OiByeCB3cSBydHdfdXNiX3J4X2hhbmRsZXIgW3J0dzg4X3VzYl0KWzQwNjIwNy44MjEzOTddIFBD
IGlzIGF0IHJ0d19yeF9maWxsX3J4X3N0YXR1cysweDQwLzB4Mjc4IFtydHdfY29yZV0KWzQwNjIw
Ny44Mjc2MDRdIExSIGlzIGF0IHJ0d19yeF9maWxsX3J4X3N0YXR1cysweDNjLzB4Mjc4IFtydHdf
Y29yZV0KWzQwNjIwNy44MzM2NjZdIHBjIDogWzxiZjMyNGNhYz5dICAgIGxyIDogWzxiZjMyNGNh
OD5dICAgIHBzcjogNDAwZjAxMTMKWzQwNjIwNy44NDAwNDNdIHNwIDogYzUzNzllMjAgIGlwIDog
YzUzNzllYjggIGZwIDogMDAwMDAwMDEKWzQwNjIwNy44NDU0MDldIHIxMDogYzNkMDAwMTggIHI5
IDogMDAwMDAwMTggIHI4IDogYzI4OTg1MjAKWzQwNjIwNy44NTA3NzVdIHI3IDogYzI4OTk3ODAg
IHI2IDogYzNkMDAwMzggIHI1IDogYzUzNzllYmMgIHI0IDogYzUzNzllODgKWzQwNjIwNy44NTc0
NTRdIHIzIDogMDAwMDAwMDAgIHIyIDogZmZmZmZmZjAgIHIxIDogMDAwMDAwMDAgIHIwIDogYzUz
NzllODgKWzQwNjIwNy44NjQwMzNdIEZsYWdzOiBuWmN2ICBJUlFzIG9uICBGSVFzIG9uICBNb2Rl
IFNWQ18zMiAgSVNBIEFSTSAgU2VnbWVudCBub25lCls0MDYyMDcuODcxMzIyXSBDb250cm9sOiAx
MGM1Mzg3ZCAgVGFibGU6IGMyOTRjMDZhICBEQUM6IDAwMDAwMDUxCls0MDYyMDcuODc3MTkyXSBS
ZWdpc3RlciByMCBpbmZvcm1hdGlvbjogbm9uLXNsYWIvdm1hbGxvYyBtZW1vcnkKWzQwNjIwNy44
ODI5NzVdIFJlZ2lzdGVyIHIxIGluZm9ybWF0aW9uOiBOVUxMIHBvaW50ZXIKWzQwNjIwNy44ODc4
NDVdIFJlZ2lzdGVyIHIyIGluZm9ybWF0aW9uOiBub24tcGFnZWQgbWVtb3J5Cls0MDYyMDcuODkz
MDEzXSBSZWdpc3RlciByMyBpbmZvcm1hdGlvbjogTlVMTCBwb2ludGVyCls0MDYyMDcuODk3Nzc4
XSBSZWdpc3RlciByNCBpbmZvcm1hdGlvbjogbm9uLXNsYWIvdm1hbGxvYyBtZW1vcnkKWzQwNjIw
Ny45MDM1NTRdIFJlZ2lzdGVyIHI1IGluZm9ybWF0aW9uOiBub24tc2xhYi92bWFsbG9jIG1lbW9y
eQpbNDA2MjA3LjkwOTMyN10gUmVnaXN0ZXIgcjYgaW5mb3JtYXRpb246IG5vbi1zbGFiL3ZtYWxs
b2MgbWVtb3J5Cls0MDYyMDcuOTE1MTAxXSBSZWdpc3RlciByNyBpbmZvcm1hdGlvbjogbm9uLXNs
YWIvdm1hbGxvYyBtZW1vcnkKWzQwNjIwNy45MjA4NzZdIFJlZ2lzdGVyIHI4IGluZm9ybWF0aW9u
OiBub24tc2xhYi92bWFsbG9jIG1lbW9yeQpbNDA2MjA3LjkyNjc1MF0gUmVnaXN0ZXIgcjkgaW5m
b3JtYXRpb246IG5vbi1wYWdlZCBtZW1vcnkKWzQwNjIwNy45MzE5MThdIFJlZ2lzdGVyIHIxMCBp
bmZvcm1hdGlvbjogbm9uLXNsYWIvdm1hbGxvYyBtZW1vcnkKWzQwNjIwNy45Mzc2OTNdIFJlZ2lz
dGVyIHIxMSBpbmZvcm1hdGlvbjogbm9uLXBhZ2VkIG1lbW9yeQpbNDA2MjA3Ljk0Mjk2NF0gUmVn
aXN0ZXIgcjEyIGluZm9ybWF0aW9uOiBub24tc2xhYi92bWFsbG9jIG1lbW9yeQpbNDA2MjA3Ljk0
ODgzOV0gUHJvY2VzcyBrd29ya2VyL3U0OjIgKHBpZDogMjMxNDUsIHN0YWNrIGxpbWl0ID0gMHhk
YWI2MGUyMikKWzQwNjIwNy45NTU2MjldIFN0YWNrOiAoMHhjNTM3OWUyMCB0byAweGM1MzdhMDAw
KQpbNDA2MjA3Ljk2MDA5OF0gOWUyMDogM2Q3NjJiZjcgYmYzYzY5Y2MgMDAwMDAwMDEgYzUzNzll
YmMgYzNkMDAwMDAgMmM0MjhmZmIgYzUzNzllYmMgYzNkMDAwMDAKWzQwNjIwNy45NjgzOTldIDll
NDA6IGMzZDAwMDM4IGMyODk5NzgwIGM1Mzc5ZTg4IGJmM2M2YjQ0IGMzZDAwMDE4IGMyODllMTA0
IGMxODA2ODAwIGNmZjY1YTgwCls0MDYyMDcuOTc2NzI4XSA5ZTYwOiAwMDAwMDBjOCBjMjg5OTc4
MCBjMjg5ZTEwOCBiZjNjYTMwMCBjMjg5ZTBmOCBiZjNjNmEzOCBjMTgwNjgwMCBiZjQxNjkyMApb
NDA2MjA3Ljk4NTA0OF0gOWU4MDogMDAwMDAwMTggYmY0MTgxNzggMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAKWzQwNjIwNy45OTMzNTJdIDllYTA6
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAxCls0MDYyMDguMDAxNjU3XSA5ZWMwOiAwMDAwMDAwMCBmZmZmZmZkNCAy
MDAyMDAwZSAwMDAwMDgwMCAwMDAwMDAwMCBmN2NhNjg3OCAwMDAwZDFkNCAzNjM5MDAzNwpbNDA2
MjA4LjAxMDA2MV0gOWVlMDogODBjYTAwMDAgZjdmNzAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMmM0MjhmZmIKWzQwNjIwOC4wMTgzNjNdIDlmMDA6IGM1
Njg0MzAwIGMyODllMTA4IGMzOTY2YjAwIGMxODA2ODAwIGMzYzE0ZTAwIDAwMDAwMDAwIGMxMzA2
NDYwIGMzYzE0ZTA1Cls0MDYyMDguMDI2NjY0XSA5ZjIwOiBjMTgwNjgwMCBjMDE0NTVjYyBjNTM3
ODAwMCBjMTgwNjgwMCBjMTgwNjgxOCBjMzk2NmIwMCBjMTgwNjgwMCBjMzk2NmIxOApbNDA2MjA4
LjAzNDk2OF0gOWY0MDogYzE4MDY4MTggYzEyMDNkMDAgMDAwMDAwODggYzUzNzgwMDAgYzE4MDY4
MDAgYzAxNDVlMDQgYzEzMzRmMzAgYzEzMDVhYjcKWzQwNjIwOC4wNDMyNzJdIDlmNjA6IDAwMDAw
MDAwIGNmYTYxZjAwIGMzZDE5MjgwIGM1Mzc4MDAwIGNmZjYzZWM0IGMwMTQ1ZGE4IGMzOTY2YjAw
IGNmYTYxZjIwCls0MDYyMDguMDUxNTc3XSA5ZjgwOiAwMDAwMDAwMCBjMDE0YzIzMCAwMDAwMDAw
MCBjM2QxOTI4MCBjMDE0YzBlYyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbNDA2MjA4LjA1
OTk4MF0gOWZhMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgYzAxMDAxMzAgMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAKWzQwNjIwOC4wNjgyODNdIDlmYzA6IDAwMDAwMDAw
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDAwMDAwCls0MDYyMDguMDc2NTg3XSA5ZmUwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAxMyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbNDA2MjA4LjA4NDkx
OF0gWzxiZjMyNGNhYz5dIChydHdfcnhfZmlsbF9yeF9zdGF0dXMgW3J0d19jb3JlXSkgZnJvbSBb
PGJmM2M2YjQ0Pl0gKHJ0dzg4MjJiX3F1ZXJ5X3J4X2Rlc2MrMHgxMGMvMHgxOWMgW3J0d184ODIy
Yl0pCls0MDYyMDguMDk2NTI0XSBbPGJmM2M2YjQ0Pl0gKHJ0dzg4MjJiX3F1ZXJ5X3J4X2Rlc2Mg
W3J0d184ODIyYl0pIGZyb20gWzxiZjQxNjkyMD5dIChydHdfdXNiX3J4X2hhbmRsZXIrMHg2Yy8w
eDE2YyBbcnR3ODhfdXNiXSkKWzQwNjIwOC4xMDc4MjBdIFs8YmY0MTY5MjA+XSAocnR3X3VzYl9y
eF9oYW5kbGVyIFtydHc4OF91c2JdKSBmcm9tIFs8YzAxNDU1Y2M+XSAocHJvY2Vzc19vbmVfd29y
aysweDFkYy8weDU4OCkKWzQwNjIwOC4xMTc1NzBdIFs8YzAxNDU1Y2M+XSAocHJvY2Vzc19vbmVf
d29yaykgZnJvbSBbPGMwMTQ1ZTA0Pl0gKHdvcmtlcl90aHJlYWQrMHg1Yy8weDU2OCkKWzQwNjIw
OC4xMjU3OTBdIFs8YzAxNDVlMDQ+XSAod29ya2VyX3RocmVhZCkgZnJvbSBbPGMwMTRjMjMwPl0g
KGt0aHJlYWQrMHgxNDQvMHgxNjApCls0MDYyMDguMTMzMzEwXSBbPGMwMTRjMjMwPl0gKGt0aHJl
YWQpIGZyb20gWzxjMDEwMDEzMD5dIChyZXRfZnJvbV9mb3JrKzB4MTQvMHgyNCkKWzQwNjIwOC4x
NDA3MjJdIEV4Y2VwdGlvbiBzdGFjaygweGM1Mzc5ZmIwIHRvIDB4YzUzNzlmZjgpCls0MDYyMDgu
MTQ1ODk1XSA5ZmEwOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbNDA2MjA4LjE1NDE5M10gOWZjMDogMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDAKWzQwNjIwOC4xNjI0OTBdIDlmZTA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwIDAwMDAwMDEzIDAwMDAwMDAwCls0MDYyMDguMTY5Mjc4XSBDb2RlOiBlNThkMzAx
NCBlM2EwMzAwMCBlYjRjNDM5ZCBlNTk4MzAxNCAoZTU5MzIwMDQpCls0MDYyMDguMTg2NTIwXSAt
LS1bIGVuZCB0cmFjZSAxNDBjMjM0MjMyYTc0YzExIF0tLS0K
--0000000000005d396b05f71c865e--
