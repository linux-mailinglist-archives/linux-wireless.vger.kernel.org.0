Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FC26D66D0
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjDDPIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 11:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDDPID (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 11:08:03 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E035B3
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 08:08:01 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id cf7so39099312ybb.5
        for <linux-wireless@vger.kernel.org>; Tue, 04 Apr 2023 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680620880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Zv8Zzj11AXdrcFh5Sltg35lke66ZAAnJwVEHWUE+Xw=;
        b=BCtSyKeqD6RXeABmugWJB9+F3p801mBaaWGt28Qok0ssPNBkGIFN3RFk+yVr1he7Gg
         45Z7NlZwItz0kxICcxujASHHTWvMFpdsiKE7mMgquYA8DxjUu4V8qhoZagQDt9SF83ng
         +aihQLTvQVcBhpCiTQTrQx37O1IalHIjh3SWgnBl3tRnSGbx58W9N4dFpBQccFr8kTFw
         JxzbtGOu00vlNswP2eVL1pBhmmfuJQWhhrvwVzaLhEfjcDD7pQt0/igDIScO+Sm5f1+F
         Yoxub9sT/82YtAfaLPqNoC5qGgTseBbLNZ11w7DgCvkxOd/rPc9dxUdvOf1+/v4WYpMo
         pzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Zv8Zzj11AXdrcFh5Sltg35lke66ZAAnJwVEHWUE+Xw=;
        b=ZV4ScbcrvQjBTfywiNfJ6h/bHwkScpag5HuLJL7PzdzpP6VaOlcRClKeo5fYnJ6byQ
         Uut1SNLKeacCOAe2mD72UJ986OSCUqx4UytPLo1VOcfqgLuijZyKnIeukxpqjjXSR0Ct
         AHbjATbscs+RSWpYFufI58cZdl/NYWdWni3FNqpr919jtj7EmW686UGd1nMgRr9cAkZG
         j4vVTyalNUzbdBxyubiGQFsPcOFfV8Hxr5+3Ye7+VQIXP7lSXsDNRnzeIu2DJ6ISbuCY
         pfbJ9hhzMczsmb7moeogkXTo6i5BM7QH2HY1Kw8MJ9uAWbIuOibfBom/SDSNzHhqhSP/
         MJIQ==
X-Gm-Message-State: AAQBX9cz8Y6ozO/nclnAt9d4/XCftaAI/W7ysnNgOgw6bO5PUc5kmoow
        yV9qgaspMi7oIpKwX+Q2nBqskrx5UVY1brYnYw==
X-Google-Smtp-Source: AKy350Y7b/8xKUEY9G2xmwddjqbl034yznigYxD1j7LMkV3dwlm1K2bLsv0Qp7Z/SUzvQpRM84y7YjKAShQU65zfvo0=
X-Received: by 2002:a25:d9d6:0:b0:b27:4632:f651 with SMTP id
 q205-20020a25d9d6000000b00b274632f651mr1758761ybg.3.1680620880357; Tue, 04
 Apr 2023 08:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+shoWQ7P49jhQasofDcTdQhiuarPTjYEDa--NiVVx494WcuQw@mail.gmail.com>
 <26b9ce8e-a100-399d-58d0-0a649380f8cb@lwfinger.net> <CA+shoWRY+wqj=5rFpM5obNB0t0=vKCJHzR0hAkf2Wz1D0ap0bw@mail.gmail.com>
 <9640df2b-1241-8ddd-8a59-a0578ff08ebf@lwfinger.net>
In-Reply-To: <9640df2b-1241-8ddd-8a59-a0578ff08ebf@lwfinger.net>
From:   Tim K <tpkuester@gmail.com>
Date:   Tue, 4 Apr 2023 11:07:47 -0400
Message-ID: <CA+shoWQ_bKF9bAeL_XWu+=B2BRGBeb+5W3uMVXQe=p5qntCkZQ@mail.gmail.com>
Subject: Re: rtw88: kernel NULL pointer dereference
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000093d6d505f8840aed"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000093d6d505f8840aed
Content-Type: text/plain; charset="UTF-8"

> As rx_status is local to the routine, the error has to be in the right-hand side
> of the statement. As hw->conf.....->center_freq is apparently OK most of the
> time, I think you are getting a spurious RX interrupt. I have pushed a patch
> that will show if hw is NULL, and quit the routine. Do a 'git pull', make... and
> let me know what you see in the log.

Updated the drivers to e6d63e1 on your github repo, and ran for about
16 hours happily. Came back this morning to an error. I've attached
the stack trace, and the line of code that caused the error.

>>> l *rtw_rx_fill_rx_status+0x48
0x8cd8 is in rtw_rx_fill_rx_status (/home/tkuester/code/rtw88/rx.c:163).
163        rx_status->freq = hw->conf.chandef.chan->center_freq;

Much to my chagrin, it seems I have an intermittent USB cable causing
spurious disconnects. However, while this does appear to be associated
with the issue, I also discovered this issue 20-some odd seconds into
boot on one boot cycle with no mention of USB disconnects.

--00000000000093d6d505f8840aed
Content-Type: application/octet-stream; name="dmesg.log"
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: base64
Content-ID: <f_lg2dm6uk0>
X-Attachment-Id: f_lg2dm6uk0

WzY5OTQyLjQ5OTM4MV0gODwtLS0gY3V0IGhlcmUgLS0tCls2OTk0Mi41MDI2NzFdIHJ0d184ODIy
YnUgMi0xLjE6MS4wOiBGaXJtd2FyZSB2ZXJzaW9uIDI3LjIuMCwgSDJDIHZlcnNpb24gMTMKWzY5
OTQyLjUwOTM2M10gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJl
bmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwNApbNjk5NDIuNTE3MTQyXSBwZ2QgPSBkMTlj
ZWM2YgpbNjk5NDIuNTIwNDc5XSBbMDAwMDAwMDRdICpwZ2Q9MDAwMDAwMDAKWzY5OTQyLjUyMzUx
NV0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDUgWyMxXSBQUkVFTVBUIFNNUCBBUk0KWzY5OTQyLjUy
ODAzNF0gTW9kdWxlcyBsaW5rZWQgaW46IGNtYWMgYWVzX2FybSBhZXNfZ2VuZXJpYyBhZXNfYXJt
X2JzIGNyeXB0b19zaW1kIGNyeXB0ZCBhbGdpZl9za2NpcGhlciBzbmRfc29jX2hkbWlfY29kZWMg
dGRhOTk1MCBydHdfODgyMmJ1KE8pIHJ0d184ODIyYihPKSBydHdfdXNiKE8pIHJ0d19jb3JlKE8p
IHJ0MjgwMHVzYiBydDJ4MDB1c2IgcnQyODAwbGliIGNyY19jY2l0dCBydDJ4MDBsaWIgbWFjODAy
MTEgc25kX3NvY19zaW1wbGVfY2FyZCBzbmRfc29jX3NpbXBsZV9jYXJkX3V0aWxzIGxpYmFyYzQg
YnR1c2IgYnRydGwgYnRiY20gYnRpbnRlbCBibHVldG9vdGggY2ZnODAyMTEgZWNkaF9nZW5lcmlj
IGVjYyBsaWJhZXMgZXRuYXZpdiBncHVfc2NoZWQgc3RtMzJfY3JjMzIgc3RtMzJfaGFzaCBjcnlw
dG9fZW5naW5lIHN0dXNiMTYweCBzbmRfc29jX3N0bTMyX2kycyB0eXBlYyBzcGlfc3RtMzIgdGRh
OTk4eCBzbmRfc29jX2NvcmUgc25kX3BjbV9kbWFlbmdpbmUgc25kX3BjbSBzdG0zMl9jZWMgc25k
X3RpbWVyIHNuZCBzb3VuZGNvcmUgbXNjYyBpcF90YWJsZXMgeF90YWJsZXMgaXB2NgpbNjk5NDIu
NTc4MjE2XSBDUFU6IDAgUElEOiA1NDIwIENvbW06IGt3b3JrZXIvdTQ6MCBUYWludGVkOiBHICAg
ICAgICAgICBPICAgICAgNS4xNS4yNCAjMTMKWzY5OTQyLjU4NjI0MV0gSGFyZHdhcmUgbmFtZTog
U1RNMzIgKERldmljZSBUcmVlIFN1cHBvcnQpCls2OTk0Mi41OTE0MDhdIFdvcmtxdWV1ZTogcnR3
ODhfdXNiOiByeCB3cSBydHdfdXNiX3J4X2hhbmRsZXIgW3J0d191c2JdCls2OTk0Mi41OTc4MTRd
IFBDIGlzIGF0IHJ0d19yeF9maWxsX3J4X3N0YXR1cysweDQ4LzB4MmI4IFtydHdfY29yZV0KWzY5
OTQyLjYwMzkxM10gTFIgaXMgYXQgcnR3X3J4X2ZpbGxfcnhfc3RhdHVzKzB4M2MvMHgyYjggW3J0
d19jb3JlXQpbNjk5NDIuNjA5OTYzXSBwYyA6IFs8YmYzODBjZDg+XSAgICBsciA6IFs8YmYzODBj
Y2M+XSAgICBwc3I6IGEwMGYwMDEzCls2OTk0Mi42MTYyMzddIHNwIDogYzM1ZTllMjAgIGlwIDog
YzM1ZTllYjggIGZwIDogMDAwMDAwMDEKWzY5OTQyLjYyMTUwMV0gcjEwOiBjNGE5MDAxOCAgcjkg
OiAwMDAwMDAxOCAgcjggOiBjM2IyMDUyMApbNjk5NDIuNjI2NzY1XSByNyA6IGMzYjIxNzgwICBy
NiA6IGM0YTkwMDM4ICByNSA6IGMzNWU5ZWJjICByNCA6IGMzNWU5ZTg4Cls2OTk0Mi42MzMzNDJd
IHIzIDogMDAwMDAwMDAgIHIyIDogZmZmZmZmZjAgIHIxIDogMDAwMDAwMDAgIHIwIDogYzM1ZTll
ODgKWzY5OTQyLjYzOTkxOV0gRmxhZ3M6IE56Q3YgIElSUXMgb24gIEZJUXMgb24gIE1vZGUgU1ZD
XzMyICBJU0EgQVJNICBTZWdtZW50IG5vbmUKWzY5OTQyLjY0NzEwNF0gQ29udHJvbDogMTBjNTM4
N2QgIFRhYmxlOiBjZmZhYzA2YSAgREFDOiAwMDAwMDA1MQpbNjk5NDIuNjUyODY5XSBSZWdpc3Rl
ciByMCBpbmZvcm1hdGlvbjogbm9uLXNsYWIvdm1hbGxvYyBtZW1vcnkKWzY5OTQyLjY1ODU0N10g
UmVnaXN0ZXIgcjEgaW5mb3JtYXRpb246IE5VTEwgcG9pbnRlcgpbNjk5NDIuNjYzMzExXSBSZWdp
c3RlciByMiBpbmZvcm1hdGlvbjogbm9uLXBhZ2VkIG1lbW9yeQpbNjk5NDIuNjY4Mzc3XSBSZWdp
c3RlciByMyBpbmZvcm1hdGlvbjogTlVMTCBwb2ludGVyCls2OTk0Mi42NzMwMzhdIFJlZ2lzdGVy
IHI0IGluZm9ybWF0aW9uOiBub24tc2xhYi92bWFsbG9jIG1lbW9yeQpbNjk5NDIuNjc4ODEwXSBS
ZWdpc3RlciByNSBpbmZvcm1hdGlvbjogbm9uLXNsYWIvdm1hbGxvYyBtZW1vcnkKWzY5OTQyLjY4
NDQ4MV0gUmVnaXN0ZXIgcjYgaW5mb3JtYXRpb246IG5vbi1zbGFiL3ZtYWxsb2MgbWVtb3J5Cls2
OTk0Mi42OTAxNTJdIFJlZ2lzdGVyIHI3IGluZm9ybWF0aW9uOiBub24tc2xhYi92bWFsbG9jIG1l
bW9yeQpbNjk5NDIuNjk1ODIzXSBSZWdpc3RlciByOCBpbmZvcm1hdGlvbjogbm9uLXNsYWIvdm1h
bGxvYyBtZW1vcnkKWzY5OTQyLjcwMTQ5NF0gUmVnaXN0ZXIgcjkgaW5mb3JtYXRpb246IG5vbi1w
YWdlZCBtZW1vcnkKWzY5OTQyLjcwNjY2MF0gUmVnaXN0ZXIgcjEwIGluZm9ybWF0aW9uOiBub24t
c2xhYi92bWFsbG9jIG1lbW9yeQpbNjk5NDIuNzEyNDMyXSBSZWdpc3RlciByMTEgaW5mb3JtYXRp
b246IG5vbi1wYWdlZCBtZW1vcnkKWzY5OTQyLjcxNzU5OV0gUmVnaXN0ZXIgcjEyIGluZm9ybWF0
aW9uOiBub24tc2xhYi92bWFsbG9jIG1lbW9yeQpbNjk5NDIuNzIzMzcxXSBQcm9jZXNzIGt3b3Jr
ZXIvdTQ6MCAocGlkOiA1NDIwLCBzdGFjayBsaW1pdCA9IDB4ZDEzZjI0MzgpCls2OTk0Mi43Mjk5
NTNdIFN0YWNrOiAoMHhjMzVlOWUyMCB0byAweGMzNWVhMDAwKQpbNjk5NDIuNzM0MzE4XSA5ZTIw
OiAzYzRkYWJmNyBiZjNhNjljYyAwMDAwMDAwMSBjMzVlOWViYyBjNGE5MDAwMCAyYzQyOGZmYiBj
MzVlOWViYyBjNGE5MDAwMApbNjk5NDIuNzQyNTE3XSA5ZTQwOiBjNGE5MDAzOCBjM2IyMTc4MCBj
MzVlOWU4OCBiZjNhNmI0NCBjNGE5MDAxOCBjM2IyNjEwNCBjMTgwNjgwMCBjZmM5YTAwMApbNjk5
NDIuNzUwODE1XSA5ZTYwOiAwMDAwMDBjOCBjM2IyMTc4MCBjM2IyNjEwOCBiZjNhYTMwMCBjM2Iy
NjBmOCBiZjNhNmEzOCBjMTgwNjgwMCBiZjFlZmEyOApbNjk5NDIuNzU5MDEyXSA5ZTgwOiAwMDAw
MDAxOCBiZjFmMTE3OCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMApbNjk5NDIuNzY3MjA5XSA5ZWEwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMQpbNjk5NDIuNzc1
NTA3XSA5ZWMwOiAwMDAwMDAwMCBmZmZmZmZjNyAyMDAwMDAxNCAwMDAwMDgwMCAwMDAwMDAwMSA0
MGE0YzJiMSAwMDAwYzdjNiAyZDMwMDAyYgpbNjk5NDIuNzgzNzA0XSA5ZWUwOiA4MGQyMDAwMCBl
OWU5MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAyYzQy
OGZmYgpbNjk5NDIuNzkxOTAyXSA5ZjAwOiBjMTMwNjQ2MCBjM2IyNjEwOCBjNGViMDkwMCBjMTgw
NjgwMCBjNTZkMjEwMCAwMDAwMDAwMCBjMTMwNjQ2MCBjNTZkMjEwNQpbNjk5NDIuODAwMjAxXSA5
ZjIwOiBjMTgwNjgwMCBjMDE0NTVjYyBjMzVlODAwMCBjMTgwNjgwMCBjMTgwNjgxOCBjNGViMDkw
MCBjMTgwNjgwMCBjNGViMDkxOApbNjk5NDIuODA4Mzk5XSA5ZjQwOiBjMTgwNjgxOCBjMTIwM2Qw
MCAwMDAwMDA4OCBjMzVlODAwMCBjMTgwNjgwMCBjMDE0NWUwNCBjMTMzNGYzMCBjMTMwNWFiNwpb
Njk5NDIuODE2NTk3XSA5ZjYwOiAwMDAwMDAwMCBjNGM4MjIwMCBjNTE1ZjI4MCBjMzVlODAwMCBj
MjliZmVjNCBjMDE0NWRhOCBjNGViMDkwMCBjNGM4MjIyMApbNjk5NDIuODI0ODk1XSA5ZjgwOiAw
MDAwMDAwMCBjMDE0YzIzMCAwMDAwMDAwMCBjNTE1ZjI4MCBjMDE0YzBlYyAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMApbNjk5NDIuODMzMDkxXSA5ZmEwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMCBjMDEwMDEzMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbNjk5NDIu
ODQxMzg4XSA5ZmMwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbNjk5NDIuODQ5NTg1XSA5ZmUwOiAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAxMyAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMApbNjk5NDIuODU3ODAzXSBbPGJmMzgwY2Q4Pl0gKHJ0d19yeF9maWxsX3J4X3N0YXR1
cyBbcnR3X2NvcmVdKSBmcm9tIFs8YmYzYTZiNDQ+XSAocnR3ODgyMmJfcXVlcnlfcnhfZGVzYysw
eDEwYy8weDE5YyBbcnR3Xzg4MjJiXSkKWzY5OTQyLjg2OTI0Ml0gWzxiZjNhNmI0ND5dIChydHc4
ODIyYl9xdWVyeV9yeF9kZXNjIFtydHdfODgyMmJdKSBmcm9tIFs8YmYxZWZhMjg+XSAocnR3X3Vz
Yl9yeF9oYW5kbGVyKzB4NmMvMHgxNmMgW3J0d191c2JdKQpbNjk5NDIuODgwMjk0XSBbPGJmMWVm
YTI4Pl0gKHJ0d191c2JfcnhfaGFuZGxlciBbcnR3X3VzYl0pIGZyb20gWzxjMDE0NTVjYz5dIChw
cm9jZXNzX29uZV93b3JrKzB4MWRjLzB4NTg4KQpbNjk5NDIuODg5ODI4XSBbPGMwMTQ1NWNjPl0g
KHByb2Nlc3Nfb25lX3dvcmspIGZyb20gWzxjMDE0NWUwND5dICh3b3JrZXJfdGhyZWFkKzB4NWMv
MHg1NjgpCls2OTk0Mi44OTgwMzVdIFs8YzAxNDVlMDQ+XSAod29ya2VyX3RocmVhZCkgZnJvbSBb
PGMwMTRjMjMwPl0gKGt0aHJlYWQrMHgxNDQvMHgxNjApCls2OTk0Mi45MDU0MzldIFs8YzAxNGMy
MzA+XSAoa3RocmVhZCkgZnJvbSBbPGMwMTAwMTMwPl0gKHJldF9mcm9tX2ZvcmsrMHgxNC8weDI0
KQpbNjk5NDIuOTEyNzQxXSBFeGNlcHRpb24gc3RhY2soMHhjMzVlOWZiMCB0byAweGMzNWU5ZmY4
KQpbNjk5NDIuOTE3ODA4XSA5ZmEwOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApbNjk5NDIuOTI2MDA1XSA5ZmMw
OiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMApbNjk5NDIuOTM0MzAwXSA5ZmUwOiAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAxMyAwMDAwMDAwMApbNjk5NDIuOTQwOTg2XSBDb2RlOiBl
YjRhZDM5NCBlMzU4MDAwMCAwYTAwMDA4YyBlNTk4MzAxNCAoZTU5MzIwMDQpCls2OTk0Mi45NDg4
OTddIC0tLVsgZW5kIHRyYWNlIGUxOTI4ZDBhOTg3ZjczMTMgXS0tLQo=
--00000000000093d6d505f8840aed--
